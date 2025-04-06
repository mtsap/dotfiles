require("noice").setup({
	views = {
		cmdline_popupmenu = {
			-- border = {
			-- 	padding = { 0, 2 },
			-- },
			position = {
				row = 7,
				col = "50%",
			},
			win_options = {
				winhighlight = { Normal = "MineGreyBg", FloatBorder = "MineBlackBg", CursorLine = "MineRedBg" },
			},
		},
	},
	presets = {
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = true,
		long_message_to_split = true,
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
	cmdline = {
		enabled = true, -- enables the Noice cmdline UI
		view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
		opts = {

			border = {
				padding = {
					top = 1,
					bottom = 1,
					left = 3,
					right = 3,
				},
				style = "rounded",
			},
			position = {
				row = 5,
				col = "50%",
			},
			win_options = {
				winhighlight = "NoiceCmdlineIcon:MineGreyBg2,Cursor:MineYellowFg,FloatBorder:MineYellowFg,Title:MineYellowFg,Normal:MineGreyBg",
			},
		}, -- global options for the cmdline. See section on views
		---@type table<string, CmdlineFormat>
		format = {
			-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
			-- view: (default is cmdline view)
			-- opts: any options passed to the view
			-- icon_hl_group: optional hl_group for the icon
			-- title: set to anything or empty string to hide
			cmdline = { pattern = "^:", icon = "", lang = "vim" },
			search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
			search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
			filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
			lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
			help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
			input = {}, -- Used by input()
			-- lua = false, -- to disable a format, set to `false`
		},
	},

	messages = {
		-- NOTE: If you enable messages, then the cmdline is enabled automatically.
		-- This is a current Neovim limitation.
		enabled = true, -- enables the Noice messages UI
		-- view = "mini", -- default view for messages
		view_error = "notify", -- view for errors
		view_warn = "notify", -- view for warnings
		view_history = "messages", -- view for :messages
		view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
	},
	popupmenu = {
		enabled = true, -- enables the Noice popupmenu UI
		view = "popupmenu",

		-- global options for the cmdline. See section on views
		---@type 'nui'|'cmp'
		backend = "nui", -- backend to use to show regular cmdline completions
		---@type NoicePopupmenuItemKind|false
		-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
		kind_icons = {}, -- set to `false` to disable icons
	},
	lsp = {
		hover = {
			enabled = false,
		},
		signature = {
			enabled = false,
		},
	},
})

vim.api.nvim_set_hl(0, "MineRedBg", { bg = "#fb4934", fg = "#282828" })
vim.api.nvim_set_hl(0, "MineRedFg", { bg = "#00ff00", fg = "#0000ff" })
vim.api.nvim_set_hl(0, "MineYellowBg", { bg = "#fabd2f", fg = "#282828" })
vim.api.nvim_set_hl(0, "MineBlackBg", { bg = "#282828", fg = "#282828" })
vim.api.nvim_set_hl(0, "MineGreyBg", { bg = "#232323", fg = "#fbf1c7" })
vim.api.nvim_set_hl(0, "MineGreyBg2", { bg = "#232323", fg = "#fb4934" })
vim.api.nvim_set_hl(0, "MineYellowFg", { bg = "#282828", fg = "#fabd2f" })
