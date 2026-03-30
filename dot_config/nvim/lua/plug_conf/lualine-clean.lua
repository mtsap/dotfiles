local colors = {
	bg = "#1d2021",
	surface = "#232728",
	surface_alt = "#2b3032",
	fg = "#ebdbb2",
	muted = "#928374",
	blue = "#7daea3",
	green = "#a9b665",
	red = "#ea6962",
	yellow = "#d8a657",
}

local theme = {
	normal = {
		a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
		b = { bg = colors.surface_alt, fg = colors.fg },
		c = { bg = colors.bg, fg = colors.fg },
	},
	insert = {
		a = { bg = colors.green, fg = colors.bg, gui = "bold" },
		b = { bg = colors.surface_alt, fg = colors.fg },
		c = { bg = colors.bg, fg = colors.fg },
	},
	visual = {
		a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
		b = { bg = colors.surface_alt, fg = colors.fg },
		c = { bg = colors.bg, fg = colors.fg },
	},
	replace = {
		a = { bg = colors.red, fg = colors.bg, gui = "bold" },
		b = { bg = colors.surface_alt, fg = colors.fg },
		c = { bg = colors.bg, fg = colors.fg },
	},
	command = {
		a = { bg = colors.fg, fg = colors.bg, gui = "bold" },
		b = { bg = colors.surface_alt, fg = colors.fg },
		c = { bg = colors.bg, fg = colors.fg },
	},
	inactive = {
		a = { bg = colors.bg, fg = colors.muted },
		b = { bg = colors.bg, fg = colors.muted },
		c = { bg = colors.bg, fg = colors.muted },
	},
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "·", right = "·" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = false,
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
					return str:sub(1, 1)
				end,
				padding = { left = 1, right = 1 },
			},
		},
		lualine_b = {
			{ "branch", icon = "" },
		},
		lualine_c = {
			{
				"filename",
				path = 1,
				shorting_target = 50,
				symbols = {
					modified = " +",
					readonly = " -",
					unnamed = "[No Name]",
					newfile = "[New]",
				},
			},
		},
		lualine_x = {
			{
				"diagnostics",
				colored = false,
				symbols = { error = "E", warn = "W", info = "I", hint = "H" },
			},
			{ "filetype", colored = false },
		},
		lualine_y = {
			{ "progress", colored = false },
		},
		lualine_z = {
			{ "location", colored = false },
		},
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
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

vim.opt.laststatus = 3
