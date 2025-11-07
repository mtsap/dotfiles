require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		-- python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { "biome" },
		typescript = { "biome" },
		typescriptreact = { "biome" },
		javascriptreact = { "biome" },
		css = { "biome" },
		scss = { "prettier" },
		html = { "prettier" },
		json = { "biome" },
		jsonc = { "biome" },
		rust = { "rustfmt" },
		-- yaml = { "yamlfmt" },
		go = { "gofmt" },
		sql = { "sleek" },
		xml = { "xmlformatter" },
		c = {},
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters = {
		yamlfmt = {
			prepend_args = { "-formatter", "retain_line_breaks_single=true,indent=2,include_document_start=true" },
		},
	},
})
