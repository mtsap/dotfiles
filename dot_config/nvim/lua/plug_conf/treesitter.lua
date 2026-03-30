local MAX_LINES = 30000
local MAX_FILESIZE = 200 * 1024

local function disable_highlight(_, bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local ok, stat = pcall(vim.uv.fs_stat, filename)

  if ok and stat and stat.size > MAX_FILESIZE then
    return true
  end

  return vim.api.nvim_buf_line_count(bufnr) > MAX_LINES
end

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "csv",
    "dockerfile",
    "go",
    "gomod",
    "gotmpl",
    "gowork",
    "graphql",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "psv",
    "python",
    "query",
    "ruby",
    "rust",
    "sql",
    "toml",
    "tsv",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
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
    disable = disable_highlight,
  },
})
