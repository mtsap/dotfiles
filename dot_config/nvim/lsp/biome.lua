return {
	cmd = { "biome", "lsp-proxy" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
		"astro",
		"svelte",
		"vue",
		"css",
	},
	-- "root_markers" is the Nvim 0.11 way to auto-detect the project root
	root_markers = { "biome.json", "biome.jsonc" },
}
