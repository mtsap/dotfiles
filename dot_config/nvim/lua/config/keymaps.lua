-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local options = { noremap = true, silent = true }
-- Move to window and tmux using the <ctrl> hjkl keys
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Go to left window" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Go to down window" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Go to up window" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Go to right window" })

local telescope_options = { noremap = true, silent = true }

map("n", "s", "<Nop>", options)
map("n", "<S-s>", "<Nop>", options)
map("n", "<Up>", "<Nop>", options)
map("n", "<Down>", "<Nop>", options)
map("n", "<Left>", "<Nop>", options)
map("n", "<Right>", "<Nop>", options)
map("v", "<Up>", "<Nop>", options)
map("v", "<Down>", "<Nop>", options)
map("v", "<Left>", "<Nop>", options)
map("v", "<Right>", "<Nop>", options)

map("n", "<leader>ff", ":Telescope find_files<cr>", telescope_options)
map("n", "<leader>fbb", ":Telescope buffers<cr>", telescope_options)
map("n", "<leader>fg", ":Telescope live_grep<cr>", telescope_options)
map("n", "<leader>fc", ":Telescope git_commits<cr>", telescope_options)
map("n", "<leader>fb", ":Telescope git_branches<cr>", telescope_options)
map("n", "<leader>fcc", ":Telescope git_bcommits<cr>", telescope_options)
map("n", "<leader>fm", ":Telescope media_files<cr>", telescope_options)

map("n", "<C-d>", "<C-d>zz", options)
map("n", "<C-u>", "<C-u>zz", options)
map("n", "n", "nzz", options)
map("n", "N", "Nzz", options)
