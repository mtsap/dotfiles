local nvim_lsp = require('lspconfig')
local util = require 'lspconfig/util'

local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end


  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>dd', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- autoformat only for haskell
  if vim.api.nvim_buf_get_option(0, 'filetype') == 'haskell' then
      vim.api.nvim_command[[
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
  end

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
--local servers = { 'tsserver' }
--for _, lsp in ipairs(servers) do
  --nvim_lsp[lsp].setup {
    --on_attach = on_attach,
    --flags = {
      --debounce_text_changes = 150,
    --}
  --}
--end


nvim_lsp.eslint.setup{}
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
      hostInfo = "neovim"
    }
  -- root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")
}


nvim_lsp.hls.setup{
    on_attach = on_attach,
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    filetypes = { "haskell", "lhaskell" },
    root_dir = util.root_pattern("*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml"),
    settings = {
      haskell = {
        hlintOn = true,
        formattingProvider = "fourmolu"
      }
    },
    single_file_support = true,
  }

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
