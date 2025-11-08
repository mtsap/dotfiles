return {
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"javascript",
		"javascriptreact",
		"javascript.jsx",
	},
	root_markers = { ".git" },

	settings = {
		typescript = {
			updateImportsOnFileMove = "always",
		},
		javascript = {
			updateImportsOnFileMove = "always",
		},
		vtsls = {
			enableMoveToFileCodeAction = true,
		},
	},
}
