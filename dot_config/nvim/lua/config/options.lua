-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
opt.conceallevel = 0
opt.mouse = ""
opt.showmode = true
opt.cursorline = false
opt.colorcolumn = "80"

vim.diagnostic.config({
  float = { border = "single" },
})

vim.api.nvim_create_user_command("Folders", "!cd %:h; folders", { nargs = "?" })
