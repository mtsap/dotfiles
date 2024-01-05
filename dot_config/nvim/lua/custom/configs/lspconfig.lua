local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

--
-- lspconfig.pyright.setup { blabla}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern "Cargo.toml",

  -- keys = {
  --   { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
  --   { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
  --   { "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
  -- },
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
}

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
