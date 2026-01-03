require("package-info").setup()

vim.api.nvim_set_keymap(
	"n",
	"<leader>ns",
	"<cmd>lua require('package-info').show({ force = true })<cr>",
	{ silent = true, noremap = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>np",
	"<cmd>lua require('package-info').change_version()<cr>",
	{ silent = true, noremap = true }
)
