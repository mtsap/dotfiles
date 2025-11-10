require("opencode").setup({
	-- The preferred picker to use for features like context item selection.
	-- Built-in options are "telescope", "fzf-lua", and "mini.pick".
	preferred_picker = "snacks",
	-- The preferred completion engine to use for features like slash commands.
	-- Built-in options are "cmp" and "native".
	preferred_completion = "blink",
	-- Whether to set the default global keymaps.
	default_global_keymaps = true,
	-- The default mode to start in.
	default_mode = "build",
	-- The prefix for all default keymaps.
	keymap_prefix = "<leader>o",
	-- A table of keymaps to override the defaults.
	keymap = {
		-- Keymaps for the main editor window.
		editor = {
			["<leader>og"] = { "toggle" },
			["<leader>oi"] = { "open_input" },
			["<leader>oI"] = { "open_input_new_session" },
			["<leader>oo"] = { "open_output" },
			["<leader>ot"] = { "toggle_focus" },
			["<leader>oq"] = { "close" },
			["<leader>os"] = { "select_session" },
			["<leader>op"] = { "configure_provider" },
			["<leader>od"] = { "diff_open" },
			["<leader>o]"] = { "diff_next" },
			["<leader>o["] = { "diff_prev" },
			["<leader>oc"] = { "diff_close" },
			["<leader>ora"] = { "diff_revert_all_last_prompt" },
			["<leader>ort"] = { "diff_revert_this_last_prompt" },
			["<leader>orA"] = { "diff_revert_all" },
			["<leader>orT"] = { "diff_revert_this" },
			["<leader>orr"] = { "diff_restore_snapshot_file" },
			["<leader>orR"] = { "diff_restore_snapshot_all" },
			["<leader>ox"] = { "swap_position" },
			["<leader>opa"] = { "permission_accept" },
			["<leader>opA"] = { "permission_accept_all" },
			["<leader>opd"] = { "permission_deny" },
		},
		-- Keymaps for the input window.
		input_window = {
			["<cr>"] = { "submit_input_prompt", mode = { "n", "i" } },
			["<esc>"] = { "close" },
			["<C-c>"] = { "cancel" },
			["~"] = { "mention_file", mode = "i" },
			["@"] = { "mention", mode = "i" },
			["/"] = { "slash_commands", mode = "i" },
			["#"] = { "context_items", mode = "i" },
			["<C-i>"] = { "focus_input", mode = { "n", "i" } },
			["<tab>"] = { "toggle_pane", mode = { "n", "i" } },
			["<up>"] = { "prev_prompt_history", mode = { "n", "i" } },
			["<down>"] = { "next_prompt_history", mode = { "n", "i" } },
			["<M-m>"] = { "switch_mode" },
		},
		-- Keymaps for the output window.
		output_window = {
			["<esc>"] = { "close" },
			["<C-c>"] = { "cancel" },
			["]]"] = { "next_message" },
			["[["] = { "prev_message" },
			["<tab>"] = { "toggle_pane", mode = { "n", "i" } },
			["i"] = { "focus_input", "n" },
			["<leader>oS"] = { "select_child_session" },
			["<leader>oD"] = { "debug_message" },
			["<leader>oO"] = { "debug_output" },
			["<leader>ods"] = { "debug_session" },
		},
		-- Keymaps for the permission window.
		permission = {
			accept = "a",
			accept_all = "A",
			deny = "d",
		},
		-- Keymaps for the session picker.
		session_picker = {
			delete_session = { "<C-d>" },
		},
	},
	-- UI configuration.
	ui = {
		-- The position of the main window.
		position = "right",
		-- The position of the input window relative to the output window.
		input_position = "bottom",
		-- The width of the main window.
		window_width = 0.40,
		-- The height of the input window.
		input_height = 0.15,
		-- Whether to display the model name in the status line.
		display_model = true,
		-- Whether to display the context size in the status line.
		display_context_size = true,
		-- Whether to display the cost in the status line.
		display_cost = true,
		-- The highlight groups for the window.
		window_highlight = "Normal:OpencodeBackground,FloatBorder:OpencodeBorder",
		-- The icons to use for the UI.
		icons = {
			-- The preset to use for icons.
			preset = "nerdfonts",
			-- A table of overrides for the preset.
			overrides = {},
		},
		-- Configuration for the output window.
		output = {
			-- Configuration for the tools display.
			tools = {
				-- Whether to show the output of tools.
				show_output = true,
			},
			-- Configuration for rendering.
			rendering = {
				-- The debounce time for rendering markdown.
				markdown_debounce_ms = 250,
				-- A function to call when data is rendered.
				on_data_rendered = nil,
			},
		},
		-- Configuration for the input window.
		input = {
			-- Configuration for the text in the input window.
			text = {
				-- Whether to wrap the text.
				wrap = false,
			},
		},
		-- Configuration for completion.
		completion = {
			-- Configuration for file sources.
			file_sources = {
				-- Whether to enable file sources.
				enabled = true,
				-- The preferred CLI tool to use for file sources.
				preferred_cli_tool = "server",
				-- A list of patterns to ignore.
				ignore_patterns = {
					"^%.git/",
					"^%.svn/",
					"^%.hg/",
					"node_modules/",
					"%.pyc$",
					"%.o$",
					"%.obj$",
					"%.exe$",
					"%.dll$",
					"%.so$",
					"%.dylib$",
					"%.class$",
					"%.jar$",
					"%.war$",
					"%.ear$",
					"target/",
					"build/",
					"dist/",
					"out/",
					"deps/",
					"%.tmp$",
					"%.temp$",
					"%.log$",
					"%.cache$",
				},
				-- The maximum number of files to display.
				max_files = 10,
				-- The maximum display length for file paths.
				max_display_length = 50,
			},
		},
	},
	-- Configuration for context gathering.
	context = {
		-- Whether to enable context gathering.
		enabled = true,
		-- Configuration for cursor data.
		cursor_data = {
			-- Whether to enable cursor data.
			enabled = true,
		},
		-- Configuration for diagnostics.
		diagnostics = {
			info = false,
			warn = true,
			error = true,
		},
		-- Configuration for the current file.
		current_file = {
			-- Whether to enable the current file.
			enabled = true,
		},
		-- Configuration for the selection.
		selection = {
			-- Whether to enable the selection.
			enabled = true,
		},
	},
	-- Configuration for debugging.
	debug = {
		-- Whether to enable debugging.
		enabled = false,
	},
	-- A function to guard prompts before they are sent.
	prompt_guard = nil,
})

