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
	--------------------
	------ NvChad  -----
	--------------------
	"nvim-lua/plenary.nvim",
	-- { "nvim-tree/nvim-web-devicons", lazy = true },
	--
	-- {
	-- 	"nvchad/ui",
	-- 	config = function()
	-- 		require("nvchad")
	-- 	end,
	-- },
	--
	-- {
	-- 	"nvchad/base46",
	-- 	lazy = true,
	-- 	build = function()
	-- 		require("base46").load_all_highlights()
	-- 	end,
	-- },
	--
	-- "nvchad/volt",

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
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = get_setup("colorschemes.catppuccin"),
	-- },
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = get_setup("colorschemes.gruvbox_material"),
	},
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
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		lazy = false, -- neo-tree will lazily load itself
		config = get_setup("neo_tree"),
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
		"ibhagwan/fzf-lua",
		dependencies = { "echasnovski/mini.icons", opts = { style = "glyph" } },
		config = get_setup("fzf"),
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = get_setup("statusline"),
	},
	{ "numToStr/FTerm.nvim", config = get_setup("fterm") },
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = get_setup("snacks"),
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

	---------------------
	------- mini --------
	---------------------
	{ "echasnovski/mini.pairs", version = "*", opts = {} },
	{
		"echasnovski/mini.surround",
		version = "*",
		config = get_setup("mini_surround"),
	},
	{ "echasnovski/mini.comment", version = false, opts = {} },
	{ "echasnovski/mini.jump", version = false, config = get_setup("mini_jump") },
	{ "echasnovski/mini.jump2d", version = false, opts = {} },
	{ "echasnovski/mini.files", version = false, opts = {} },
	{ "echasnovski/mini.icons", version = false, opts = { style = "glyph" } },
	---------------------
	-------  LSP --------
	---------------------

	{
		"neovim/nvim-lspconfig",
		config = get_setup("lsp"),
	},
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
	{
		"nvimdev/lspsaga.nvim",
		config = get_setup("lspsaga"),
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
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
}
local opts = {}

require("lazy").setup(plugins, opts)
