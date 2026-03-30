local colors = {
	bg = "#1d2021",
	surface = "#292929",
	surface_alt = "#32302f",
	surface_warm = "#3a312d",
	surface_moss = "#2e3834",
	surface_rose = "#3a2d2f",
	surface_gold = "#3a3528",
	muted = "#bdae93",
	fg = "#ebdbb2",
	red = "#ea6962",
	green = "#a9b665",
	yellow = "#d8a657",
	blue = "#7daea3",
	aqua = "#89b482",
	orange = "#e78a4e",
	gray = "#504945",
}

local theme = {
	normal = {
		a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
		b = { bg = colors.surface_alt, fg = colors.fg },
		c = { bg = colors.surface, fg = colors.muted },
	},
	insert = {
		a = { bg = colors.red, fg = colors.bg, gui = "bold" },
		b = { bg = colors.surface_alt, fg = colors.fg },
		c = { bg = colors.surface, fg = colors.muted },
	},
	visual = {
		a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
		b = { bg = colors.surface_alt, fg = colors.fg },
		c = { bg = colors.surface, fg = colors.muted },
	},
	replace = {
		a = { bg = colors.red, fg = colors.bg, gui = "bold" },
		b = { bg = colors.surface_alt, fg = colors.fg },
		c = { bg = colors.surface, fg = colors.muted },
	},
	command = {
		a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
		b = { bg = colors.surface_alt, fg = colors.fg },
		c = { bg = colors.surface, fg = colors.muted },
	},
	terminal = {
		a = { bg = colors.fg, fg = colors.bg, gui = "bold" },
		b = { bg = colors.surface_alt, fg = colors.fg },
		c = { bg = colors.surface, fg = colors.muted },
	},
	inactive = {
		a = { bg = colors.surface, fg = colors.gray },
		b = { bg = colors.surface, fg = colors.gray },
		c = { bg = colors.surface, fg = colors.gray },
	},
}

local function file_icon()
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if not ok then
		return "󰈔"
	end

	local filename = vim.fn.expand("%:t")
	local extension = vim.fn.expand("%:e")
	local icon = devicons.get_icon(filename, extension, { default = false })

	if not icon then
		icon = devicons.get_icon_by_filetype(vim.bo.filetype, { default = true })
	end

	return icon or "󰈔"
end

local function unique_names(names)
	local seen = {}
	local result = {}

	for _, name in ipairs(names) do
		if name and name ~= "" and not seen[name] then
			seen[name] = true
			table.insert(result, name)
		end
	end

	return result
end

local function compact_names(names, max_items)
	if #names == 0 then
		return ""
	end

	local shown = {}
	for i = 1, math.min(#names, max_items) do
		table.insert(shown, names[i])
	end

	local text = table.concat(shown, ",")
	if #names > max_items then
		text = text .. "+" .. (#names - max_items)
	end

	return text
end

local function lsp_clients()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	local names = {}

	for _, client in ipairs(clients) do
		if client.name ~= "null-ls" and client.name ~= "copilot" then
			table.insert(names, client.name)
		end
	end

	return unique_names(names)
end

local function lsp_status()
	return compact_names(lsp_clients(), 2)
end

local function has_lsp()
	return #lsp_clients() > 0
end

local function tool_status()
	local parts = {}

	do
		local ok, conform = pcall(require, "conform")
		if ok then
			local formatters = {}
			for _, name in ipairs(conform.list_formatters_for_buffer(0) or {}) do
				local info = conform.get_formatter_info(name, 0)
				if info.available then
					table.insert(formatters, name)
				end
			end

			formatters = unique_names(formatters)
			if #formatters > 0 then
				table.insert(parts, "fmt:" .. compact_names(formatters, 2))
			end
		end
	end

	do
		local ok, lint = pcall(require, "lint")
		if ok then
			local linters = unique_names(lint.linters_by_ft[vim.bo.filetype] or {})
			if #linters > 0 then
				table.insert(parts, "lint:" .. compact_names(linters, 2))
			end
		end
	end

	return table.concat(parts, "  ")
end

local function has_tools()
	return tool_status() ~= ""
end

local function recording_status()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		return ""
	end

	return "REC @" .. reg
end

local function is_recording()
	return vim.fn.reg_recording() ~= ""
end

local function search_status()
	if vim.v.hlsearch == 0 then
		return ""
	end

	local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 120 })
	if not ok or next(result) == nil or result.total == 0 then
		return ""
	end

	return string.format("%d/%d", result.current, math.min(result.total, result.maxcount))
end

local function is_searching()
	return search_status() ~= ""
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "│", right = "│" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = true,
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return " " .. str:sub(1, 1) .. str:sub(2):lower() .. " "
				end,
			},
		},
		lualine_b = {
			{ "branch", icon = "", color = { bg = colors.surface, fg = colors.muted } },
			{ "diff", colored = true, color = { bg = colors.surface, fg = colors.muted } },
		},
		lualine_c = {
			{
				file_icon,
				color = { bg = colors.surface_alt, fg = colors.orange },
				separator = { left = "", right = "" },
				padding = { left = 1, right = 0 },
			},
			{
				"filename",
				filestatus = true,
				path = 1,
				shorting_target = 40,
				color = { bg = colors.surface_alt, fg = colors.fg, gui = "bold" },
				separator = { left = "", right = "" },
				padding = { left = 1, right = 1 },
				symbols = {
					modified = " ●",
					readonly = " ",
					unnamed = " [No Name]",
					newfile = " [New]",
				},
			},
			{
				lsp_status,
				cond = has_lsp,
				icon = { "󰒋", color = { fg = colors.orange } },
				color = { bg = colors.surface_warm, fg = colors.fg, gui = "bold" },
				separator = { left = "", right = "" },
				padding = { left = 1, right = 1 },
			},
			{
				tool_status,
				cond = has_tools,
				icon = { "󱉶", color = { fg = colors.aqua } },
				color = { bg = colors.surface_moss, fg = colors.fg },
				separator = { left = "", right = "" },
				padding = { left = 1, right = 1 },
			},
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				colored = true,
				color = { bg = colors.surface_alt },
				separator = { left = "", right = "" },
				padding = { left = 1, right = 1 },
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = "󰌵 ",
				},
				diagnostics_color = {
					error = { fg = colors.red, bg = colors.surface_alt, gui = "bold" },
					warn = { fg = colors.yellow, bg = colors.surface_alt, gui = "bold" },
					info = { fg = colors.blue, bg = colors.surface_alt, gui = "bold" },
					hint = { fg = colors.aqua, bg = colors.surface_alt, gui = "bold" },
				},
			},
			{
				recording_status,
				cond = is_recording,
				icon = { "󰑋", color = { fg = colors.red } },
				color = { bg = colors.surface_rose, fg = colors.fg, gui = "bold" },
				separator = { left = "", right = "" },
				padding = { left = 1, right = 1 },
			},
			{
				search_status,
				cond = is_searching,
				icon = { "", color = { fg = colors.yellow } },
				color = { bg = colors.surface_gold, fg = colors.fg },
				separator = { left = "", right = "" },
				padding = { left = 1, right = 1 },
			},
			{ "filetype", colored = false },
		},
		lualine_y = { { "progress" } },
		lualine_z = { { "location" } },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			{ "filename", path = 0 },
		},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = {
			{
				"buffers",
				mode = 0,
				max_length = function()
					return math.floor(vim.o.columns * 0.4)
				end,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				padding = { left = 0, right = 1 },
				buffers_color = {
					active = { bg = colors.orange, fg = colors.bg, gui = "bold" },
					inactive = { bg = colors.bg, fg = colors.gray },
				},
			},
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

vim.opt.laststatus = 3
