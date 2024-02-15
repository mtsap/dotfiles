local M = {}

M.treesitter = {
    ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
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
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
        -- disable = {
        --   "python"
        -- },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
}

M.mason = {
    ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "prettier",
        "eslint_d",
        --rust
        "rust-analyzer",
    },
}

-- git support in nvimtree
M.nvimtree = {
    git = {
        enable = true,
    },

    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = true,
            },
        },
    },
}

return M
