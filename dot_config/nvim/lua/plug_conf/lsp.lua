-- local util = require("lspconfig/util")
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

local function on_attach(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set(mode.normal, "K", function()
		vim.lsp.buf.hover({ border = "single" })
	end, { noremap = true, silent = true })
end

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "ts_ls", "clangd", "lua_ls" }

for _, lsp in ipairs(servers) do
	vim.lsp.config(lsp, {

		on_attach = on_attach,
		capabilities = capabilities,
	})
end

vim.lsp.config("yamlls", {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		redhat = { telemetry = { enabled = false } },
		yaml = {
			schemaStore = {
				enable = true,
				url = "https://www.schemastore.org/api/json/catalog.json",
			},
			format = { enabled = false },
			-- enabling this conflicts between Kubernetes resources, kustomization.yaml, and Helmreleases
			validate = false,
			schemas = {
				kubernetes = "*.yaml",
				["https://github.com/fluxcd-community/flux2-schemas"] = "*.yaml",
				["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
				["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
				["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines*.{yml,yaml}",
				["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = "roles/tasks/*.{yml,yaml}",
				["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = "*play*.{yml,yaml}",
				["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
				["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
				["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
				["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
				["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
				["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
				["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
			},
		},
	},
})

vim.lsp.config("gopls", {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	-- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
		},
	},
})

vim.lsp.config("rust_analyzer", {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "rust" },
	-- root_dir = util.root_pattern("Cargo.toml"),

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

vim.lsp.config("jsonls", {})

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

-- vim.keymap.set(mode.normal, "gD", function()
-- 	vim.lsp.buf.declaration()
-- end, { noremap = true, silent = true })
--
-- vim.keymap.set(mode.normal, "gd", function()
-- 	vim.lsp.buf.definition()
-- end, { noremap = true, silent = true })
--
-- vim.keymap.set(mode.normal, "<leader>D", function()
-- 	vim.lsp.buf.type_definition()
-- end, { noremap = true, silent = true })
--
--
-- vim.keymap.set(mode.normal, "gi", function()
-- 	vim.lsp.buf.implementation()
-- end, { noremap = true, silent = true })
--
-- vim.keymap.set(mode.normal, "<leader>ls", function()
-- 	vim.lsp.buf.signature_help({ border = "single", max_height = 30, max_width = 100 })
-- end, { noremap = true, silent = true })
--
-- vim.keymap.set(mode.normal, "gr", function()
-- 	vim.lsp.buf.references()
-- end, { noremap = true, silent = true })
--
-- vim.keymap.set(mode.normal, "<leader>lf", function()
-- 	vim.lsp.buf.open_float({ border = "rounded" })
-- end, { noremap = true, silent = true })
--
-- vim.keymap.set(mode.normal, "[d", function()
-- 	vim.diagnostic.goto_prev({ float = { border = "rounded" } })
-- end, { noremap = true, silent = true })
--
-- vim.keymap.set(mode.normal, "]d", function()
-- 	vim.diagnostic.goto_next({ float = { border = "rounded" } })
-- end, { noremap = true, silent = true })
--
-- vim.keymap.set(mode.normal, "<leader>q", function()
-- 	vim.diagnostic.setloclist()
-- end, { noremap = true, silent = true })
vim.lsp.enable()
