vim.g.mapleader = " "

local mode = require("consts").modes

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
