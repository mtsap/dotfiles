local Mode = require("consts").modes

require("neo-tree").setup({})

vim.keymap.set(Mode.normal, "<leader><Tab>", ":Neotree toggle<CR>", { noremap = true, silent = true })
