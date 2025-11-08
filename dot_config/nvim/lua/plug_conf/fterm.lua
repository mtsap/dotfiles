local Mode = require("config.consts").modes
local fterm = require("FTerm")
fterm.setup({
	border = "rounded",
	dimensions = {
		height = 0.66,
		width = 0.66,
	},
})

vim.keymap.set(Mode.normal, "<A-i>", function()
	require("FTerm").toggle()
end, {})
vim.keymap.set("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
