require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  --ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  context_commentstring = {
    enable = true
  },
  indent = {
      enable = true
    },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      none_incremental = "grn",
      sccpe_incremental = "grc",
      node_decremental = "grm",
    },
  },
  rainbow = {
      enable = true,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
  }
}
--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.typescript.used_by = { "javascript", "typescript.tsx" }
