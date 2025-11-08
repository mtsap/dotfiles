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
		lsp_doc_border = true, -- add a border to hover docs and signature help
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
				winhighlight = "NoiceCmdlineIcon:MineGreyBg2,Cursor:MineYellowFg,FloatBorder:FloatBorder,Title:MineYellowFg,Normal:MineGreyBg",
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
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},

		hover = {
			enabled = true,
			view = "hover", -- you can change this to another view if you want
			opts = {
				-- options go here
				border = {
					style = "rounded", -- or "single", "double", "solid", etc
				},
				padding = { 1, 2 },
				win_options = {
					winhighlight = {
						Normal = "NormalFloat",
						FloatBorder = "FloatBorder",
					},
					-- e.g. hide cursorline, change conceallevel, etc
					concealcursor = "n",
					conceallevel = 3,
				},
				size = {
					max_width = 80,
					max_height = 20,
					width = "auto",
					height = "auto",
				},
			},
		},
		signature = {
			enabled = true,
			view = "hover",
		},
	},
})
