require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		-- python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { "oxfmt" },
		typescript = { "oxfmt" },
		typescriptreact = { "oxfmt" },
		javascriptreact = { "oxfmt" },
		css = { "oxfmt" },
		scss = { "prettier" },
		html = { "prettier" },
		json = { "oxfmt" },
		jsonc = { "oxfmt" },
		rust = { "rustfmt" },
		yaml = { "yamlfmt" },
		go = { "goimports", "gofmt" },
		sql = { "sleek" },
		xml = { "xmllint" },
		python = { "isort", "black" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 1000,
	},
	notify_on_error = true,
	formatters = {
		oxfmt = {
			cwd = require("conform.util").root_file({
				".oxfmtrc.json",
				".oxfmtrc.jsonc",
				"oxfmt.config.ts",
				"oxfmt.config.mts",
				"oxfmt.config.cts",
				"oxfmt.config.js",
				"oxfmt.config.mjs",
				"oxfmt.config.cjs",
			}),
		},
		yamlfmt = {
			prepend_args = { "-formatter", "retain_line_breaks_single=true,indent=2,include_document_start=true" },
		},
	},
})
