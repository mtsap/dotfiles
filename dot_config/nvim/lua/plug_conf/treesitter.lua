local DISABLE_HIGHLIGHT_THRESHOLD = 30000

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "cpp",
    "css",
    "go",
    "html",
    "lua",
    "typescript",
    "vim",
    "javascript",
    "tsx",
    "json",
    "c",
    "yaml",
    "xml",
    "tsv",
    "toml",
    "sql",
    "rust",
    "ruby",
    "python",
    "psv",
    "graphql",
    "dockerfile",
    "csv",
    "bash",
    "markdown",
    "markdown_inline",
    -- go
    "go",
    "gomod",
    "gowork",
    "gotmpl",
  },
  auto_install = true,
  sync_install = false,
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = function(_lang, _bufnr)
      return vim.api.nvim_buf_line_count(0) > DISABLE_HIGHLIGHT_THRESHOLD
    end,
  }
})
