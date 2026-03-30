local ok, schemastore = pcall(require, "schemastore")

return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml" },
	settings = {
		yaml = {
			format = { enable = false },
			validate = true,
			hover = true,
			completion = true,
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = ok and schemastore.yaml.schemas() or {},
		},
	},
}
