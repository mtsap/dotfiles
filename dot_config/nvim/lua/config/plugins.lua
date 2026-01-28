--------------------
-- Bootstrap lazy --
--------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

--------------------
----- Plugins ------
--------------------
local function get_setup(conf_name)
	return function(_plugin, _opts)
		local mod = string.format("plug_conf.%s", conf_name)
		require(mod)
	end
end

local plugins = {
	"nvim-lua/plenary.nvim",
	--------------------
	-- Colorschemes ----
	--------------------
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	priority = 1000,
	-- 	config = get_setup("colorschemes.gruvbox"),
	-- },

	-- {
	-- 	"luisiacc/gruvbox-baby",
	-- 	priority = 1000,
	-- 	config = get_setup("colorschemes.gruvbox_baby"),
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = get_setup("colorschemes.catppuccin"),
	},
	-- {
	-- 	"sainnhe/gruvbox-material",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = get_setup("colorschemes.gruvbox_material"),
	-- },
	-- {
	-- 	"sainnhe/everforest",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = get_setup("everforest"),
	-- },
	-- {
	-- 	"comfysage/evergarden",
	-- 	priority = 1000,
	-- 	lazy = false,
	-- 	config = get_setup("evergarden"),
	-- },
	--------------------
	-- /Colorschemes/ ----
	--------------------

	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		-- keys = {
		-- 	{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
		-- 	{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
		-- 	{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
		-- 	{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		-- 	{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		-- },
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = get_setup("dashboard"),
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = get_setup("treesitter"),
	},
	{

		"stevearc/conform.nvim",
		config = get_setup("conform"),
	},
	{
		"williamboman/mason.nvim",
		config = get_setup("mason"),
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = get_setup("statusline"),
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = get_setup("snacks"),
	},
	{
		"dzfrias/arena.nvim",
		event = "BufWinEnter",
		-- Calls `.setup()` automatically
		config = true,
		keys = {
			{ "<leader>fb", "<cmd>lua require('arena').toggle()<cr>", desc = "Arena" },
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
		config = get_setup("noice"),
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		config = get_setup("flash"),
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	---------------------
	------- mini --------
	---------------------
	{ "nvim-mini/mini.pairs", version = "*" },
	{
		"nvim-mini/mini.surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "ys",
					delete = "sd",
					find = "sf",
					find_left = "sF",
					highlight = "sh",
					replace = "sr",
					update_n_lines = "sn",
				},
				search_method = "cover",
			})
		end,
	},
	{ "nvim-mini/mini.comment", version = "*" },
	{ "nvim-mini/mini.icons", version = "*" },
	---------------------
	-------  LSP --------
	---------------------
	{

		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"moyiz/blink-emoji.nvim",
			"Kaiser-Yang/blink-cmp-dictionary",
			"onsails/lspkind.nvim",
		},
		version = "1.*",
		build = "cargo build --release",
		config = get_setup("blink"),
	},
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = get_setup("lint"),
	},
	-- {
	-- 	"nvimdev/lspsaga.nvim",
	-- 	config = get_setup("lspsaga"),
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter", -- optional
	-- 		"nvim-tree/nvim-web-devicons", -- optional
	-- 	},
	-- },
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
		},
	},

	---------------------
	-------  GIT --------
	---------------------
	{
		"tpope/vim-fugitive",
		lazy = false,
		keys = {
			{
				"<leader>gi",
				"<cmd>Git<CR>",
				{
					noremap = true,
					silent = true,
				},
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = get_setup("gitsigns"),
	},
	-- {
	-- 	"kdheepak/lazygit.nvim",
	-- 	lazy = true,
	-- 	cmd = {
	-- 		"LazyGit",
	-- 		"LazyGitConfig",
	-- 		"LazyGitCurrentFile",
	-- 		"LazyGitFilter",
	-- 		"LazyGitFilterCurrentFile",
	-- 	},
	-- 	-- optional for floating window border decoration
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- 	-- order to load the plugin when the command is run for the first time
	-- 	keys = {
	-- 		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
	-- 	},
	-- },

	---------------------
	-------  SQL --------
	---------------------
	---
	---
	{
		"tpope/vim-dadbod",
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},

	---------------------
	-----  Markdown -----
	---------------------
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},

	---------------------
	-----  NODE -----
	---------------------
	{
		"vuki656/package-info.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = get_setup("package-info"),
	},

	---------------------
	-----  Golang -----
	---------------------
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		-- branch = "develop"
		-- (optional) will update plugin's deps on every update

		config = function(_, opts)
			require("gopher").setup(opts)
		end,
		build = function()
			vim.cmd.GoInstallDeps()
		end,
		---@type gopher.Config
	},

	---------------------
	-----  AI -----
	---------------------
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},
	-- {
	-- 	"sudo-tee/opencode.nvim",
	-- 	config = get_setup("opencode"),
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		{
	-- 			"MeanderingProgrammer/render-markdown.nvim",
	-- 			opts = {
	-- 				anti_conceal = { enabled = false },
	-- 				file_types = { "markdown", "opencode_output" },
	-- 			},
	-- 			ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
	-- 		},
	-- 		-- Optional, for file mentions and commands completion, pick only one
	-- 		"saghen/blink.cmp",
	-- 		-- 'hrsh7th/nvim-cmp',
	--
	-- 		-- Optional, for file mentions picker, pick only one
	-- 		"folke/snacks.nvim",
	-- 		-- 'nvim-telescope/telescope.nvim',
	-- 		-- 'ibhagwan/fzf-lua',
	-- 		-- 'nvim_mini/mini.nvim',
	-- 	},
	-- },
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
				provider = {
					enabled = "tmux",
				},
			}

			-- Required for `opts.events.reload`.
			vim.o.autoread = true

			-- Recommended/example keymaps.
			vim.keymap.set({ "n", "x" }, "<leader>a", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })
			vim.keymap.set({ "n", "x" }, "<leader>as", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "x" }, "<leader>ay", function()
				require("opencode").toggle()
			end, { desc = "Toggle opencode" })

			vim.keymap.set({ "n", "x" }, "go", function()
				return require("opencode").operator("@this ")
			end, { expr = true, desc = "Add range to opencode" })
			vim.keymap.set("n", "goo", function()
				return require("opencode").operator("@this ") .. "_"
			end, { expr = true, desc = "Add line to opencode" })

			vim.keymap.set("t", "<C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "opencode half page up" })
			vim.keymap.set("t", "<C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "opencode half page down" })

			-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
			vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
			vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
		end,
	},
	{
		"catgoose/nvim-colorizer.lua",
		cmd = "ColorizerToggle",
		keys = {
			{ "<leader>ux", "<cmd>ColorizerToggle<cr>", desc = "Colorizer" },
		},
		opts = {},
	},
}

local opts = {
	ui = {
		border = "none", -- border style: "none", "single", "double", "rounded", etc.
		title = "Lazy", -- Title shown on the dashboard
		pills = true, -- Show plugin category pills

		icons = {
			loaded = "✓",
			not_loaded = "✗",
		},

		-- Custom dashboard section
		custom_dashboard = {
			header = {
				"██╗      █████╗ ███████╗██╗   ██╗",
				"██║     ██╔══██╗██╔════╝██║   ██║",
				"██║     ███████║███████╗██║   ██║",
				"██║     ██╔══██║╚════██║██║   ██║",
				"███████╗██║  ██║███████║╚██████╔╝",
				"╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ",
			},
			footer = {
				"",
				"🚀 Happy Hacking with Neovim!",
			},
		},
	},
}

require("lazy").setup(plugins, opts)
