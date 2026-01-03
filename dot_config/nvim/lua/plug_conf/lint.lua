local lint = require("lint")

-- lint.linters.golangci_lint = {
-- 	cmd = "golangci-lint",
-- 	stdin = false,
-- 	args = {
-- 		"run",
-- 		"--out-format",
-- 		"json",
-- 		"--path-prefix",
-- 		vim.fn.getcwd(),
-- 	},
-- 	stream = "stdout",
-- 	ignore_exitcode = true,
-- 	parser = require("lint.parser").from_errorformat([[
--   %#%f:%l:%c: %m
--   %#%f:%l: %m
--   ]]),
-- }

lint.linters_by_ft = {
	-- javascript = { "biomejs" },
	-- typescript = { "biomejs" },
	-- typescriptreact = { "biomejs" },
	-- javascriptreact = { "biomejs" },
	-- css = { "biomejs" },
	go = { "golangcilint" },
	yaml = { "yamllint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

vim.keymap.set("n", "<leader>li", function()
	lint.try_lint()
end, { desc = "Trigger linting for current file" })
