local mode = require("consts").modes
local lspsaga = require("lspsaga")
lspsaga.setup({
	finder = {
		max_height = 1,
		max_width = 1,
		keys = {
			vsplit = "v",
		},
	},
	lightbulb = {
		enable = false,
	},
})

vim.keymap.set(mode.normal, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { noremap = true, silent = true })

-- vim.keymap.set(mode.normal, "gD", function()
-- 	vim.lsp.buf.declaration()
-- end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "gd", "<cmd>Lspsaga peek_definition<CR>", { noremap = true, silent = true })

vim.keymap.set(mode.normal, "<leader>D", "<cmd>Lspsaga peek_type_definition<CR>", { noremap = true, silent = true })

-- vim.keymap.set(mode.normal, "K", "<cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true })

vim.keymap.set(mode.normal, "gi", "<cmd>Lspsaga finder<CR>", { noremap = true, silent = true })

vim.keymap.set(mode.normal, "gr", "<cmd>Lspsaga finder ref<CR>", { noremap = true, silent = true })

vim.keymap.set(mode.normal, "<leader>ls", function()
	vim.lsp.buf.signature_help({ border = "single", max_height = 30, max_width = 100 })
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "<leader>lf", function()
	vim.lsp.buf.open_float({ border = "rounded" })
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "[d", function()
	vim.diagnostic.goto_prev({ float = { border = "rounded" } })
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "]d", function()
	vim.diagnostic.goto_next({ float = { border = "rounded" } })
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "<leader>q", function()
	vim.diagnostic.setloclist()
end, { noremap = true, silent = true })
