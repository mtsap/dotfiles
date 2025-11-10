-- lua/multi_ts_build.lua
--
-- A custom module to asynchronously build multiple TS projects
-- and populate the quickfix list with any errors.

local M = {}

---
-- !! IMPORTANT !!
-- You must configure this table with the absolute paths to your projects.
--
-- Give each project a name and the path to its root directory
-- (the directory containing `tsconfig.json`).
--
local projects = {
	-- UPDATED: Changed this project path as you requested
	--
	{ name = "shared:countries", path = "/home/mtsap/code/tm/monorepo/packages/shared/countries" },
	{ name = "shared:dates", path = "/home/mtsap/code/tm/monorepo/packages/shared/dates" },
	{ name = "shared:schemas", path = "/home/mtsap/code/tm/monorepo/packages/shared/schemas" },
	{ name = "shared:utils", path = "/home/mtsap/code/tm/monorepo/packages/shared/utils" },
	{ name = "backend:admin-trpc", path = "/home/mtsap/code/tm/monorepo/packages/backend/admin-trpc" },
	{ name = "admins:admin", path = "/home/mtsap/code/tm/monorepo/apps/admin" },
	-- Add as many projects as you need
	-- { name = "Another Project", path = "/path/to/another/project" },
}

---
-- Configuration for the module
--
local config = {
	-- How to display the error list.
	-- "quickfix": Use the standard quickfix window (:copen)
	-- "snacks": Use the snacks.nvim picker (requires snacks.nvim, cmd may need adjusting)
	-- "telescope": Use the telescope.nvim picker (requires telescope.nvim)
	-- "none": Just populate the list, don't open any UI
	open_ui = "snacks", -- Default (was "quickfix")
}

---
-- Public config function so users can override it from init.lua
--
function M.setup(user_config)
	config = vim.tbl_deep_extend("force", config, user_config or {})
end

---
-- Parses the output from the 'tsc' compiler.
-- @param output_str (string) The combined stdout/stderr from tsc.
-- @param project_path (string) The absolute path to the project's root.
-- @return (table) A list of quickfix items.
--
local function parse_tsc_output(output_str, project_path)
	local qf_items = {}
	-- FIX: The variable here is `project_path` (a string), not `project` (an object)
	local tsconfig_path = vim.fn.fnamemodify(project_path .. "/tsconfig.json", ":p")

	-- TSC error format 1 (pretty: true, default): path/to/file.ts:line:col - error TSXXXX: Error message.
	local pattern1 = "(.-):(%d+):(%d+) - error (TS%d+): (.*)"
	-- TSC error format 2 (pretty: false): path/to/file.ts(line,col): error TSXXXX: Error message.
	local pattern2 = "(.-)%((%d+),(%d+)%): error (TS%d+): (.*)"
	-- TSC project-level error: error TSXXXX: Error message.
	local pattern3 = "^error (TS%d+): (.*)"

	for line in vim.gsplit(output_str, "\n") do
		local rel_path, lnum, col, code, msg
		local full_path

		-- Try pattern 1
		rel_path, lnum, col, code, msg = string.match(line, pattern1)
		if rel_path then
			-- FIX: Was using `project.path` (undefined) instead of `project_path`
			full_path = vim.fn.fnamemodify(project_path .. "/" .. rel_path, ":p")
			lnum = tonumber(lnum)
			col = tonumber(col)
		end

		-- If pattern 1 failed, try pattern 2
		if not rel_path then
			rel_path, lnum, col, code, msg = string.match(line, pattern2)
			if rel_path then
				-- FIX: Was using `project.path` (undefined) instead of `project_path`
				full_path = vim.fn.fnamemodify(project_path .. "/" .. rel_path, ":p")
				lnum = tonumber(lnum)
				col = tonumber(col)
			end
		end

		-- If pattern 2 failed, try pattern 3 (project-level)
		if not rel_path then
			code, msg = string.match(line, pattern3)
			if code then
				full_path = tsconfig_path -- Attribute project errors to the tsconfig file
				lnum = 1
				col = 1
				-- msg and code are already captured correctly
			end
		end

		if full_path then
			table.insert(qf_items, {
				filename = full_path,
				lnum = lnum,
				col = col,
				text = msg .. " (" .. code .. ")",
				type = "E", -- 'E' for Error
				nr = tonumber(string.sub(code, 3)), -- Error number
			})
		end
	end

	return qf_items
end

---
-- The main function to be called by your keymap.
-- It builds all configured projects asynchronously.
--
function M.build_all_projects()
	if #projects == 0 then
		vim.notify("No projects configured in lua/multi_ts_build.lua", vim.log.levels.WARN)
		return
	end

	local all_qf_items = {}
	local jobs_to_run = #projects
	local any_build_failed = false -- Track if *any* job fails
	local start_time = vim.loop.hrtime()

	vim.notify("Starting builds for " .. jobs_to_run .. " projects...", vim.log.levels.INFO)

	-- This function is called every time a job (build) finishes
	local function on_job_exit(result, project)
		-- tsc can output to stdout or stderr
		local output = result.stdout .. "\n" .. result.stderr

		if result.code == 0 then
			vim.notify("Build success: " .. project.name, vim.log.levels.INFO)
		else
			vim.notify("Build failed: " .. project.name .. " (code: " .. result.code .. ")", vim.log.levels.WARN)
			any_build_failed = true -- Mark that a failure occurred

			-- DEBUG: Print raw output to :messages on failure
			print("--- Raw output for failed project: " .. project.name .. " ---")
			vim.print(output)
			print("-----------------------------------------------------")
		end

		-- Parse the output and add any found errors to our master list
		local project_errors = parse_tsc_output(output, project.path)
		for _, item in ipairs(project_errors) do
			table.insert(all_qf_items, item)
		end

		-- Decrement the job counter
		jobs_to_run = jobs_to_run - 1

		-- If all jobs are done, we can finalize and show the quickfix list
		if jobs_to_run == 0 then
			-- We must schedule the UI update for the main thread
			vim.schedule(function()
				local end_time = vim.loop.hrtime()
				local duration_ms = (end_time - start_time) / 1000000
				local duration_s = string.format("%.2f", duration_ms / 1000)

				if #all_qf_items > 0 then
					-- Populate the quickfix list
					vim.fn.setqflist({}, "r", {
						title = "TS Multi-Project Build Errors",
						items = all_qf_items,
					})

					-- Open the UI based on configuration
					if config.open_ui == "snacks" then
						-- NOTE: 'Snacks qflist' is a common command, but you
						-- may need to change this if your snacks.nvim setup is different.
						require("snacks").picker.qflist()
					elseif config.open_ui == "telescope" then
						-- Assumes telescope.nvim is installed
						vim.cmd("Telescope quickfix")
					elseif config.open_ui == "quickfix" then
						-- Open the standard quickfix window
						vim.cmd("copen")
					elseif config.open_ui == "none" then
						-- Do nothing, just populate the list
					end

					vim.notify(
						string.format("Build finished in %ss with %d errors.", duration_s, #all_qf_items),
						vim.log.levels.ERROR
					)
				elseif any_build_failed then
					-- Builds failed but we couldn't parse any errors
					vim.cmd("cclose")
					vim.notify(
						string.format("Build finished in %ss with unparsed errors. Check :TscBuild output.", duration_s),
						vim.log.levels.ERROR
					)
				else
					-- No errors, clean up and celebrate
					vim.cmd("cclose")
					vim.notify(
						string.format("All projects built successfully in %ss.", duration_s),
						vim.log.levels.INFO
					)
				end
			end)
		end
	end

	-- Start all the build jobs
	for _, project in ipairs(projects) do
		-- Using `npx` is often safer to find the local `tsc`
		-- FIX: Add "--pretty false" to disable color codes and get parseable output
		local build_cmd = { "npx", "tsc", "-p", project.path, "--noEmit", "--pretty", "false" }

		vim.notify("Building: " .. project.name .. "...", vim.log.levels.INFO)

		-- Run the async command
		vim.system(build_cmd, {
			cwd = project.path, -- Run the command in the project's directory
			text = true, -- Ensure stdout/stderr are strings
		}, function(result)
			-- `result` contains .code, .stdout, .stderr
			on_job_exit(result, project)
		end)
	end
end

return M
