return {
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
	},
	root_markers = {
		".git",
		"pnpm-workspace.yaml",
		"lerna.json",
		"turbo.json",
		"nx.json",
	},

	settings = {
		typescript = {
			updateImportsOnFileMove = "always",
			tsserver = {
				experimental = {
					enableProjectDiagnostics = true,
				},
			},
		},
		javascript = {
			updateImportsOnFileMove = "always",
		},
		vtsls = {
			enableMoveToFileCodeAction = true,
		},
	},
	vtsls = {
		autoUseWorkspaceTsdk = true, -- uses your project's local typescript
		experimental = {
			completion = {
				enableServerSideFuzzyMatch = true,
			},
		},
	},
}
