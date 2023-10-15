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

vim.api.nvim_create_user_command("Simple", function(opts)
  local path = vim.fn.expand("%:h")
  print(opts.fargs[1], opts.fargs[2], "weeeeee")
  if opts.fargs[2] == nil then
    os.execute("cd " .. path .. "; folders -t " .. opts.fargs[1] .. ";")
  else
    os.execute("cd " .. path .. "; folders -t " .. opts.fargs[1] .. " -n " .. opts.fargs[2] .. ";")
  end
end, { nargs = "*" })
