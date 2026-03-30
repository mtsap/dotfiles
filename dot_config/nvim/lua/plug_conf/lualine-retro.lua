local colors = {
	bg = "#1d2021",
	black = "#141617",
	surface = "#292929",
	fg = "#ebdbb2",
	gray = "#a89984",
	red = "#ea6962",
	green = "#a9b665",
	yellow = "#d8a657",
	blue = "#7daea3",
	purple = "#d3869b",
	aqua = "#89b482",
	orange = "#e78a4e",
}

local theme = {
	normal = {
		a = { bg = colors.red, fg = colors.black, gui = "bold" },
		b = { bg = colors.yellow, fg = colors.black, gui = "bold" },
		c = { bg = colors.surface, fg = colors.fg },
	},
	insert = {
		a = { bg = colors.green, fg = colors.black, gui = "bold" },
		b = { bg = colors.aqua, fg = colors.black, gui = "bold" },
		c = { bg = colors.surface, fg = colors.fg },
	},
	visual = {
		a = { bg = colors.purple, fg = colors.black, gui = "bold" },
		b = { bg = colors.blue, fg = colors.black, gui = "bold" },
		c = { bg = colors.surface, fg = colors.fg },
	},
	replace = {
		a = { bg = colors.orange, fg = colors.black, gui = "bold" },
		b = { bg = colors.yellow, fg = colors.black, gui = "bold" },
		c = { bg = colors.surface, fg = colors.fg },
	},
	command = {
		a = { bg = colors.blue, fg = colors.black, gui = "bold" },
		b = { bg = colors.purple, fg = colors.black, gui = "bold" },
		c = { bg = colors.surface, fg = colors.fg },
	},
	inactive = {
		a = { bg = colors.surface, fg = colors.gray },
		b = { bg = colors.surface, fg = colors.gray },
		c = { bg = colors.surface, fg = colors.gray },
	},
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
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
					return " " .. str:upper() .. " "
				end,
			},
		},
		lualine_b = {
			{ "branch", icon = "" },
			{ "diff" },
			{ "diagnostics" },
		},
		lualine_c = {
			{
				"filename",
				filestatus = true,
				path = 1,
				shorting_target = 30,
			},
		},
		lualine_x = {
			{ "encoding", fmt = string.upper },
			"fileformat",
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = {
			{
				"buffers",
				mode = 2,
				use_mode_colors = true,
				max_length = vim.o.columns * 2 / 3,
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
