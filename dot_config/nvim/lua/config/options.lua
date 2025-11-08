vim.opt.conceallevel = 0
vim.opt.mouse = ""
vim.opt.showmode = true
vim.opt.cursorline = false
vim.opt.colorcolumn = "80"
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.signcolumn = "number"
vim.opt.mouse = ""
vim.opt_local.textwidth = 80
vim.wo.wrap = false

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.showmode = false

vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true

vim.opt.signcolumn = "yes"
vim.opt.timeoutlen = 400
vim.opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
vim.opt.updatetime = 250

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- General settings:
--------------------

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = "500" })
	end,
})

vim.diagnostic.config({

	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		texthl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
	},
})
