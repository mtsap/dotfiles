local opencode = require("opencode")

---@type opencode.Opts
vim.o.autoread = true

vim.keymap.set({ "n", "x" }, "<leader>a", function()
	opencode.ask("@this: ", { submit = true })
end, { desc = "Ask opencode" })

vim.keymap.set({ "n", "x" }, "<leader>as", function()
	opencode.select()
end, { desc = "Execute opencode action..." })

vim.keymap.set({ "n", "x" }, "<leader>ay", function()
	opencode.toggle()
end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "go", function()
	return opencode.operator("@this ")
end, { expr = true, desc = "Add range to opencode" })

vim.keymap.set("n", "goo", function()
	return opencode.operator("@this ") .. "_"
end, { expr = true, desc = "Add line to opencode" })

vim.keymap.set("t", "<C-u>", function()
	opencode.command("session.half.page.up")
end, { desc = "opencode half page up" })

vim.keymap.set("t", "<C-d>", function()
	opencode.command("session.half.page.down")
end, { desc = "opencode half page down" })

vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
