return {
	cmd = { "typescript-language-server", "--stdio" },
	root_markers = { "package.json", "tsconfig.json", ".git" },
	-- root_dir = function(fname)
	-- 	local root_files = vim.fs.find(
	-- 		{ "tsconfig.json", "package.json" },
	-- 		{ upward = true, path = fname, type = "file", limit = 1 }
	-- 	)
	--
	-- 	-- If we found a file, return its directory.
	-- 	if root_files and #root_files > 0 then
	-- 		return vim.fs.dirname(root_files[1])
	-- 	end
	--
	-- 	-- Otherwise, return nil and let the server decide
	-- 	return nil
	-- end,
	filetypes = {
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"javascript",
		"javascriptreact",
		"javascript.jsx",
	},
}
