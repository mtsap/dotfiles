local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local mode = require("consts").modes

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "ts_ls", "clangd", "gopls", "lua_ls" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "rust" },
	root_dir = util.root_pattern("Cargo.toml"),

	settings = {
		cargo = {
			allFeatures = true,
			loadOutDirsFromCheck = true,
			runBuildScripts = true,
		},
		diagnostics = {
			enable = true,
		},
		checkOnSave = {
			allFeatures = true,
			command = "clippy",
			extraArgs = { "--no-deps" },
		},
		inlayHints = { typeHints = { enable = true } },
		procMacro = {
			enable = true,
			ignored = {
				["async-trait"] = { "async_trait" },
				["napi-derive"] = { "napi" },
				["async-recursion"] = { "async_recursion" },
			},
		},
	},
})

lspconfig.jsonls.setup({})

local border = {
	{ "🭽", "MyFloatBorder" },
	{ "▔", "MyFloatBorder" },
	{ "🭾", "MyFloatBorder" },
	{ "▕", "MyFloatBorder" },
	{ "🭿", "MyFloatBorder" },
	{ "▁", "MyFloatBorder" },
	{ "🭼", "MyFloatBorder" },
	{ "▏", "MyFloatBorder" },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = border,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = border,
})

-- vim.keymap.set(mode.normal, "<leader>ca", function()
-- 	vim.lsp.buf.code_action()
-- end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "gD", function()
	vim.lsp.buf.declaration()
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "gd", function()
	vim.lsp.buf.definition()
end, { noremap = true, silent = true })
vim.keymap.set(mode.normal, "<leader>D", function()
	vim.lsp.buf.type_definition()
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "K", function()
	vim.lsp.buf.hover({ border = "single", max_height = 30, max_width = 100 })
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "gi", function()
	vim.lsp.buf.implementation()
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "<leader>ls", function()
	vim.lsp.buf.signature_help({ border = "single", max_height = 30, max_width = 100 })
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "gr", function()
	vim.lsp.buf.references()
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "<leader>lf", function()
	vim.lsp.buf.open_float({ border = "rounded" })
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "[d", function()
	vim.diagnostic.goto_prev({ float = { border = "rounded" } })
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "]d", function()
	vim.diagnostic.goto_next({ float = { border = "rounded" } })
end, { noremap = true, silent = true })

vim.keymap.set(mode.normal, "<leader>q", function()
	vim.diagnostic.setloclist()
end, { noremap = true, silent = true })
