local Mode = require("consts").modes
local fzf = require("fzf-lua")

vim.keymap.set(Mode.normal, "<leader>ff", function()
	fzf.files()
end, { noremap = true })

vim.keymap.set(Mode.normal, "<leader>fa", function()
	fzf.files({
		no_ignore = true,
	})
end, { noremap = true })

vim.keymap.set(Mode.normal, "<leader>fg", function()
	fzf.live_grep_native()
end, { noremap = true })

vim.keymap.set(Mode.normal, "<leader>fb", function()
	fzf.buffers()
end, { noremap = true })

vim.keymap.set(Mode.normal, "<leader>fb", function()
	fzf.buffers()
end, { noremap = true })

-- handled in lspsaga
-- vim.keymap.set(Mode.normal, "<leader>ca", function()
-- 	fzf.lsp_code_actions({
-- 		winopts = {
-- 			backdrop = 60,
-- 			height = 0.50, -- window height
-- 			width = 0.40,
-- 			preview = { hidden = true },
-- 		},
-- 	})
-- end, { noremap = true, silent = true })
