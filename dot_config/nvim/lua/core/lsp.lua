local methods = vim.lsp.protocol.Methods

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
	capabilities = capabilities,
	handlers = {
		[methods.textDocument_hover] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		[methods.textDocument_signatureHelp] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	},
})

vim.lsp.enable({
	"tsgo",
	"gopls",
	"basedpyright",
	"jsonls",
	"yamlls",
	"oxlint",
})

local lsp_attach_group = vim.api.nvim_create_augroup("lsp-attach", { clear = true })
local lsp_highlight_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = true })
local lsp_detach_group = vim.api.nvim_create_augroup("lsp-detach", { clear = true })

local function buffer_has_highlight_client(bufnr, excluding_client_id)
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		if client.id ~= excluding_client_id and client:supports_method(methods.textDocument_documentHighlight, bufnr) then
			return true
		end
	end

	return false
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_attach_group,
	callback = function(event)
		local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
		local snacks = require("snacks")

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
		map("<leader>gk", vim.diagnostic.goto_prev, "Previous Diagnostic")
		map("<leader>gj", vim.diagnostic.goto_next, "Next Diagnostic")
		map("<leader>fx", snacks.picker.diagnostics, "Diagnostics")
		map("<leader>x", snacks.picker.diagnostics_buffer, "Buffer Diagnostics")

		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("gs", vim.lsp.buf.signature_help, "Signature Help")

		map("<leader>gd", snacks.picker.lsp_definitions, "Goto Definition")
		map("<leader>gi", snacks.picker.lsp_implementations, "Goto Implementation")
		map("<leader>gD", snacks.picker.lsp_declarations, "Goto Declaration")
		map("<leader>gr", function()
			snacks.picker.lsp_references({
				layout = { layout = { width = 0.95, height = 0.95 } },
			})
		end, "Goto References")
		map("<leader>gv", function()
			vim.cmd.vsplit()
			vim.lsp.buf.definition()
		end, "Goto Definition in Vertical Split")

		if client:supports_method(methods.textDocument_typeDefinition, event.buf) then
			map("gy", snacks.picker.lsp_type_definitions, "Goto Type Definition")
		end

		map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map("<leader>lr", vim.lsp.buf.rename, "Rename")
		map("<leader>lf", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, "Format")

		if client:supports_method(methods.textDocument_documentHighlight, event.buf) then
			vim.api.nvim_clear_autocmds({ group = lsp_highlight_group, buffer = event.buf })

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = lsp_highlight_group,
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				group = lsp_highlight_group,
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_clear_autocmds({ group = lsp_detach_group, buffer = event.buf })

			vim.api.nvim_create_autocmd("LspDetach", {
				group = lsp_detach_group,
				buffer = event.buf,
				callback = function(event2)
					if buffer_has_highlight_client(event2.buf, event2.data.client_id) then
						return
					end

					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = lsp_highlight_group, buffer = event2.buf })
				end,
			})
		end
	end,
})

vim.diagnostic.config({
	virtual_lines = false,
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
