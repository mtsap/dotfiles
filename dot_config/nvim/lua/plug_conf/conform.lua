require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    -- python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    javascript = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    javascriptreact = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    json = { "jq" },
    rust = { "rustfmt" },
    yaml = { "yamlfmt" },
    go = { "gofmt" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters = {
    yamlfmt = {
      prepend_args = { "-formatter", "retain_line_breaks_single=true" },
    },
  },
})
