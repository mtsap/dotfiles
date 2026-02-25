vim.g.mapleader = " "

local mode = require("config.consts").modes
local multi_ts_build = require("config.multi_build")

opts = { noremap = true, silent = true }

vim.keymap.set(mode.normal, "s", "<Nop>", opts)
vim.keymap.set(mode.normal, "<S-s>", "<Nop>", opts)
vim.keymap.set(mode.normal, "<S>", "<Nop>", opts)
vim.keymap.set(mode.normal, "<Up>", "<Nop>", opts)
vim.keymap.set(mode.normal, "<Down>", "<Nop>", opts)
vim.keymap.set(mode.normal, "<Left>", "<Nop>", opts)
vim.keymap.set(mode.normal, "<Right>", "<Nop>", opts)

vim.keymap.set(mode.normal, "<C-d>", "<C-d>zz", opts)
vim.keymap.set(mode.normal, "<C-u>", "<C-u>zz", opts)
vim.keymap.set(mode.normal, "n", "nzz", opts)
vim.keymap.set(mode.normal, "N", "Nzz", opts)

vim.keymap.set(mode.visual, "<Up>", "<Nop>", opts)
vim.keymap.set(mode.visual, "<Down>", "<Nop>", opts)
vim.keymap.set(mode.visual, "<Left>", "<Nop>", opts)
vim.keymap.set(mode.visual, "<Right>", "<Nop>", opts)

vim.keymap.set(mode.normal, "<Esc>", "<cmd> noh <CR>", { noremap = true, silent = true, desc = "Clear highlights" })
vim.keymap.set(
	mode.normal,
	"p",
	'p:let @+=@0<CR>:let @"=@0<CR>',
	{ noremap = true, silent = true, desc = "Don't copy replaced text" }
)
vim.keymap.set(mode.visual, "p", "P", { noremap = true, silent = true, desc = "Don't copy replaced text in visual" })

vim.keymap.set("n", "<leader>b", multi_ts_build.build_all_projects, {
	desc = "Build all configured TS projects",
})

-- vim.keymap.set(
-- 	{ mode.normal, mode.visual, mode.terminal },
-- 	"<C-h>",
-- 	"<cmd>TmuxNavigateLeft<cr>",
-- 	{ desc = "skip left pane" }
-- )
-- vim.keymap.set(
-- 	{ mode.normal, mode.visual, mode.terminal },
-- 	"<C-j>",
-- 	"<cmd>TmuxNavigateDown<cr>",
-- 	{ desc = "skip down pane" }
-- )
-- vim.keymap.set(
-- 	{ mode.normal, mode.visual, mode.terminal },
-- 	"<C-k>",
-- 	"<cmd>TmuxNavigateUp<cr>",
-- 	{ desc = "skip up pane" }
-- )
-- vim.keymap.set(
-- 	{ mode.normal, mode.visual, mode.terminal },
-- 	"<C-l>",
-- 	"<cmd>TmuxNavigateRight<cr>",
-- 	{ desc = "skip right pane" }
-- )
