require("blink.cmp").setup({

	-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
	-- 'super-tab' for mappings similar to vscode (tab to accept)
	-- 'enter' for enter to accept
	-- 'none' for no mappings
	--
	-- All presets have the following mappings:
	-- C-space: Open menu or open docs if already open
	-- C-n/C-p or Up/Down: Select next/previous item
	-- C-e: Hide menu
	-- C-k: Toggle signature help (if signature.enabled = true)
	--
	-- See :h blink-cmp-config-keymap for defining your own keymap
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },

		["<S-k>"] = { "scroll_documentation_up", "fallback" },
		["<S-j>"] = { "scroll_documentation_down", "fallback" },
		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },

		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
	},

	signature = {
		enabled = true,
		window = { border = "rounded" },
	},

	appearance = {
		-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},

	-- (Default) Only show the documentation popup when manually triggered
	-- completion = { documentation = { auto_show = false } },
	completion = {
		accept = { auto_brackets = { enabled = true } },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 100,
			update_delay_ms = 50,
			treesitter_highlighting = true,
			window = { border = "rounded" },
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
			border = "rounded",
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind" },
				},
				treesitter = { "lsp" },
			},
		},
	},

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			-- lazydev = {
			-- 	name = "LazyDev",
			-- 	module = "lazydev.integrations.blink",
			-- 	-- Make lazydev completions top priority (see `:h blink.cmp`)
			-- 	score_offset = 100,
			-- },
			-- lsp = {
			-- 	min_keyword_length = 0, -- Number of characters to trigger provider
			-- 	score_offset = 0, -- Boost/penalize the score of the items
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

	-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	--
	-- See the fuzzy documentation for more information
	fuzzy = { implementation = "prefer_rust" },
})
