local Mode = require("consts").modes

require("neo-tree").setup({
	filesystem = {
		bind_to_cwd = false,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
	},
})

vim.keymap.set(Mode.normal, "<leader><Tab>", ":Neotree toggle<CR>", { noremap = true, silent = true })
