local colors = {
	base = "#1d2021",
	mantle = "#191b1c",
	crust = "#141617",
	surface = "#292929",
	surface_alt = "#32302f",
	warm = "#3a312d",
	frame = "#4a3525",
	text = "#ebdbb2",
	muted = "#bdae93",
	red = "#ea6962",
	green = "#a9b665",
	blue = "#7daea3",
	pink = "#d3869b",
	orange = "#e78a4e",
	aqua = "#89b482",
	yellow = "#d8a657",
}

require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
		-- ["<Tab>"] = { "select_next", "fallback" },
		-- ["<S-Tab>"] = { "select_prev", "fallback" },
		["<S-k>"] = { "scroll_documentation_up", "fallback" },
		["<S-j>"] = { "scroll_documentation_down", "fallback" },
		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
	},
	signature = {
		enabled = false,
		window = { border = "single" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		accept = { auto_brackets = { enabled = true } },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 100,
			update_delay_ms = 50,
			treesitter_highlighting = true,
			window = {
				border = "single",
				min_width = 20,
				max_width = 68,
				max_height = 16,
				winblend = 0,
				scrollbar = false,
			},
		},
		list = {
			selection = {
				preselect = false,
				auto_insert = false,
			},
		},
		ghost_text = {
			enabled = vim.g.ai_cmp,
		},
		menu = {
			border = "single",
			min_width = 24,
			max_height = 12,
			winblend = 0,
			scrollbar = false,
			draw = {
				padding = { 1, 1 },
				gap = 1,
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "source_name" },
				},
				components = {
					source_name = {
						width = { max = 4 },
						text = function(ctx)
							local tags = {
								LSP = "LSP",
								Path = "PATH",
								Snippets = "SNIP",
								Buffer = "BUF",
								Dadbod = "DB",
							}

							return tags[ctx.source_name] or string.upper(ctx.source_name)
						end,
						highlight = "BlinkCmpSource",
					},
				},
				treesitter = { "lsp" },
			},
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		per_filetype = {
			sql = { "dadbod", "snippets", "buffer" },
		},
		providers = {
			dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			-- lazydev = {
			-- 	name = "LazyDev",
			-- 	module = "lazydev.integrations.blink",
			-- 	score_offset = 100,
			-- },
			-- lsp = {
			-- 	min_keyword_length = 0,
			-- 	score_offset = 0,
			-- },
			-- path = {
			-- 	min_keyword_length = 0,
			-- },
			-- snippets = {
			-- 	min_keyword_length = 2,
			-- },
			-- buffer = {
			-- 	min_keyword_length = 4,
			-- 	max_items = 5,
			-- },
		},
	},
	fuzzy = { implementation = "prefer_rust" },
})

vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = colors.mantle, fg = colors.text })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = colors.mantle, fg = colors.orange, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = colors.orange, fg = colors.base, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = colors.text })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = colors.yellow, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { fg = colors.muted })
vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = colors.muted })
vim.api.nvim_set_hl(0, "BlinkCmpKind", { fg = colors.orange, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = colors.text })
vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = colors.orange, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = colors.orange, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpKindConstructor", { fg = colors.orange })
vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = colors.aqua })
vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = colors.text })
vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = colors.aqua })
vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = colors.blue, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { fg = colors.blue })
vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = colors.blue })
vim.api.nvim_set_hl(0, "BlinkCmpKindUnit", { fg = colors.green })
vim.api.nvim_set_hl(0, "BlinkCmpKindValue", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpKindEnum", { fg = colors.yellow, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = colors.red })
vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = colors.green, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpKindColor", { fg = colors.pink })
vim.api.nvim_set_hl(0, "BlinkCmpKindFile", { fg = colors.green })
vim.api.nvim_set_hl(0, "BlinkCmpKindReference", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpKindFolder", { fg = colors.blue })
vim.api.nvim_set_hl(0, "BlinkCmpKindEnumMember", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpKindStruct", { fg = colors.blue, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpKindEvent", { fg = colors.pink })
vim.api.nvim_set_hl(0, "BlinkCmpKindOperator", { fg = colors.red })
vim.api.nvim_set_hl(0, "BlinkCmpKindTypeParameter", { fg = colors.aqua })
	vim.api.nvim_set_hl(0, "BlinkCmpSource", { fg = colors.muted })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = colors.crust, fg = colors.text })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = colors.crust, fg = colors.frame })
vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { fg = colors.surface_alt, italic = true })
