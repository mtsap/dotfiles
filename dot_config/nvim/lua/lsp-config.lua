local opts = { noremap=true, silent=true }
-- vim.keymap.set('n', 'K', vim.lsp.buf.hover,opts)
vim.keymap.set('n', 'rr', vim.diagnostic.goto_next,opts)
vim.keymap.set('n', 're', vim.diagnostic.goto_prev,opts)



vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = false,
    float = {
        show_header = true,
        source = 'always',
        border = 'rounded',
        focusable = true,
    },
    update_in_insert = false, -- default to false
    severity_sort = false, -- default to false
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
