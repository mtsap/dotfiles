local mode = require("consts").modes

local servers = {
	ts_ls = {
		cmd = { "typescript-language-server", "--stdio" },
		root_markers = { "package.json", "tsconfig.json", ".git" },
		-- root_dir = function(fname)
		-- 	local root_files = vim.fs.find(
		-- 		{ "tsconfig.json", "package.json" },
		-- 		{ upward = true, path = fname, type = "file", limit = 1 }
		-- 	)
		--
		-- 	-- If we found a file, return its directory.
		-- 	if root_files and #root_files > 0 then
		-- 		return vim.fs.dirname(root_files[1])
		-- 	end
		--
		-- 	-- Otherwise, return nil and let the server decide
		-- 	return nil
		-- end,
		filetypes = {
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"javascript",
			"javascriptreact",
			"javascript.jsx",
		},
	},
	tsgo = {

		cmd = {
			"tsgo",
			"--lsp",
			"--stdio",
		},

		-- root_markers = { "package.json", "tsconfig.json", ".git" },
		root_dir = function(fname)
			local root_files = {
				"tsconfig.base.json",
				"tsconfig.json",
				"jsconfig.json",
				"package.json",
				".git",
			}

			local found = vim.fs.find(root_files, {
				upward = true,
				path = fname,
				stop = vim.loop.os_homedir(),
			})

			if #found > 0 then
				return vim.fs.dirname(found[1])
			else
				return vim.fn.getcwd()
			end
		end,
		filetypes = {
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"javascript",
			"javascriptreact",
			"javascript.jsx",
		},
	},
	lua_ls = {
		cmd = { "lua-language-server" },
		settings = {
			Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false } },
		},
	},
	html = { cmd = { "vscode-html-language-server", "--stdio" } },
	cssls = { cmd = { "vscode-css-language-server", "--stdio" } },
	-- clangd = { cmd = { "clangd" } },
	gopls = {
		cmd = { "gopls", "-remote=auto" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_markers = { "go.work", "go.mod", ".git" },
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				analyses = {
					unusedparams = true,
					unreachable = true,
				},
			},
		},
	},
}

local float_border = {
	{ "╭", "MyFloatBorder" },
	{ "─", "MyFloatBorder" },
	{ "╮", "MyFloatBorder" },
	{ "│", "MyFloatBorder" },
	{ "╯", "MyFloatBorder" },
	{ "─", "MyFloatBorder" },
	{ "╰", "MyFloatBorder" },
	{ "│", "MyFloatBorder" },
}

-- Optional: on_attach and capabilities
local function on_attach(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set(mode.normal, "K", function()
		vim.lsp.buf.hover()
	end, { noremap = true, silent = true })
end

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

for name, config in pairs(servers) do
	vim.lsp.config(name, { -- call as function!
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = float_border }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = float_border }),
		},
		-- merge server-specific config
		cmd = config.cmd,
		filetypes = config.filetypes,
		root_markers = config.root_markers,
		settings = config.settings,
	})
end

-- Enable the servers
vim.lsp.enable({
	-- "ts_ls",
	"tsgo",
	"lua_ls",
	-- "clangd",
	"html",
	"cssls",
	"gopls",
	-- "biome",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf
		on_attach(client, bufnr)
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
	callback = function(args)
		-- Get all active tsgo clients
		local clients = vim.lsp.get_clients({ name = "tsgo" })
		if not clients or vim.tbl_isempty(clients) then
			return
		end

		-- Notify tsgo that a file changed
		for _, client in ipairs(clients) do
			client.notify("workspace/didChangeWatchedFiles", {
				changes = {
					{
						uri = vim.uri_from_fname(args.file),
						type = 2, -- 1 = Created, 2 = Changed, 3 = Deleted
					},
				},
			})
		end
	end,
})
