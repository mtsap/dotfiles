require("mason").setup({
	ensure_installed = {
		"yamlfmt",
		"yaml-language-server",
		"yamllint",
		"jq",

		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"json-lsp",
		"typescript-language-server",
		"deno",
		"prettier",
		"eslint_d",
		"oxfmt",
		--rust
		"rust-analyzer",
		"rust-fmt",
		--go
		"gopls",
		"goimports",
		"golangcilint",
	},
})
