require("mason").setup({
	ensure_installed = {
		"yamlfmt",
		"yamllint",
		"jq",

		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettier",
		"eslint_d",
		--rust
		"rust-analyzer",
		"rust-fmt",
		--go
		"gopls",
		"goimports",
		"golangcilint",
	},
})
