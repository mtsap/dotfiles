local Mode = require("config.consts").modes

-- -- Optional: on_attach and capabilities
-- local function on_attach(client, bufnr)
-- 	local opts = { noremap = true, silent = true, buffer = bufnr }
--
-- 	local map = function(keys, func, desc)
-- 		vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
-- 	end
--
-- 	map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
-- 	map("[d", vim.diagnostic.prev, "Diagnostic Next")
-- 	map("]d", vim.diagnostic.goto_next, "Diagnostic Prev")
--
-- 	map("K", vim.lsp.buf.hover, "Hover Documentation")
-- 	map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
--
-- 	map("<leader>gd", vim.lsp.buf.type_definition, "Goto Type Definition")
-- 	map("<leader>gv", "<cmd>vsplit | lua vim. lsp.buf.definition() <cr>", "Goto Definition in Vertical Split")
-- 	map("<leader>gr", vim.lsp.references, "Goto references")
-- 	map("gD", vim.lsp.buf.declaration, "Goto Declaration")
--
-- 	map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
-- 	map("<leader>lr", vim.lsp.buf.rename, "Rename all references")
-- 	map("<leader>lf", vim.lsp.buf.format, "Format")
-- end

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

-- for name, config in pairs(servers) do
-- 	vim.lsp.config(name, { -- call as function!
-- 		on_attach = on_attach,
-- 		capabilities = capabilities,
-- 		handlers = {
-- 			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = float_border }),
-- 			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = float_border }),
-- 		},
-- 		-- merge server-specific config
-- 		cmd = config.cmd,
-- 		filetypes = config.filetypes,
-- 		root_markers = config.root_markers,
-- 		settings = config.settings,
-- 	})
-- end

-- Enable the servers
vim.lsp.enable({
	-- "vtsls",
	"ts_ls",
	-- "tsgo",
	-- "lua_ls",
	-- "clangd",
	-- "html",
	-- "cssls",
	"gopls",
	-- "biome",
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
		map("<leader>gj", vim.diagnostic.goto_prev, "Diagnostic Next")
		map("<leader>gk", vim.diagnostic.goto_next, "Diagnostic Prev")
		map("<leader>fx", require("snacks").picker.diagnostics, "Diagnostic")
		map("<leader>x", require("snacks").picker.diagnostics_buffer, "Buffer Diagnostic")

		-- ugly
		map("K", function()
			vim.lsp.buf.hover()
		end, "Hover Documentation")
		map("gs", vim.lsp.buf.signature_help, "Signature Documentation")

		map("<leader>gd", function()
			require("snacks").picker.lsp_definitions()
		end, "Goto Type Definition")

		map("<leader>gi", require("snacks").picker.lsp_implementations, "Diagnostic")
		map("<leader>gD", require("snacks").picker.lsp_declarations, "Diagnostic")
		map("<leader>gr", function()
			require("snacks").picker.lsp_references({
				layout = { layout = { width = 0.95, height = 0.95 } },
			})
		end, "Goto references")
		map("<leader>gv", "<cmd>vsplit | lua vim.lsp.buf.definition() <cr>", "Goto Definition in Vertical Split")

		-- { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
		-- { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
		-- { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
		-- { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		-- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

		map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map("<leader>lr", vim.lsp.buf.rename, "Rename all references")
		map("<leader>lf", vim.lsp.buf.format, "Format")

		local function client_supports_method(client, method, bufnr)
			if vim.fn.has("nvim-0.11") == 1 then
				return client:supports_method(method, bufnr)
			else
				return client.supports_method(method, { bufnr = bufnr })
			end
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if
			client
			and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
		then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

			-- When cursor stops moving: Highlights all instances of the symbol under the cursor
			-- When cursor moves: Clears the highlighting
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			-- When LSP detaches: Clears the highlighting
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end
	end,
})

vim.diagnostic.config({
	virtual_lines = true,
	virtual_text = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
