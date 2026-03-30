local ok, schemastore = pcall(require, "schemastore")

return {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	init_options = {
		provideFormatter = false,
	},
	settings = {
		json = {
			schemas = ok and schemastore.json.schemas() or {},
			validate = { enable = true },
		},
	},
}
