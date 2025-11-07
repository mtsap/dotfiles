local lint = require("lint")

-- lint.linters.golangci_lint = {
-- 	cmd = "golangci-lint",
-- 	stdin = false,
-- 	args = {
-- 		"run",
-- 		"--out-format",
-- 		"json",
-- 		"--path-prefix",
-- 		vim.fn.getcwd(),
-- 	},
-- 	stream = "stdout",
-- 	ignore_exitcode = true,
-- 	parser = require("lint.parser").from_errorformat([[
--   %#%f:%l:%c: %m
--   %#%f:%l: %m
--   ]]),
-- }

-- lint.linters.tsc = {
-- 	cmd = "npx",
-- 	args = { "tsc", "--noEmit", "--pretty", "false" },
-- 	-- We parse the output to get the error details
-- 	parser = function(output)
-- 		local diagnostics = {}
-- 		for line in vim.fn.split(output, "\n") do
-- 			local parts = vim.fn.split(line, ":", 1) -- Split only on first ':'
-- 			if #parts >= 2 then
-- 				local file_line_col = vim.fn.split(parts[1], ":")
-- 				local msg = parts[2]
-- 				if #file_line_col >= 3 and msg then
-- 					local file = file_line_col[1]
-- 					local line_num = tonumber(file_line_col[2])
-- 					local col_num = tonumber(file_line_col[3])
-- 					-- Extract error code like "TS2345"
-- 					local error_code = msg:match("%s*(TS%d+)%s*:")
-- 					table.insert(diagnostics, {
-- 						filename = file,
-- 						lnum = line_num,
-- 						col = col_num,
-- 						message = msg,
-- 						code = error_code,
-- 						severity = vim.diagnostic.severity.ERROR,
-- 						source = "tsc",
-- 					})
-- 				end
-- 			end
-- 		end
-- 		return diagnostics
-- 	end,
-- }

lint.linters_by_ft = {
	javascript = { "biomejs" },
	typescript = { "biomejs" },
	typescriptreact = { "biomejs" },
	javascriptreact = { "biomejs" },
	css = { "biomejs" },
	go = { "golangcilint" },
	yaml = { "yamllint" },
}

-- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
-- 	group = lint_augroup,
-- 	callback = function()
-- 		lint.try_lint()
-- 	end,
-- })

vim.keymap.set("n", "<leader>li", function()
	lint.try_lint()
end, { desc = "Trigger linting for current file" })
