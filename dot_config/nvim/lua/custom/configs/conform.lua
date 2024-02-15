local conform = require "conform"

conform.setup {
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        -- python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "jq" },
        rust = { "rustfmt" },
        yaml = { "yamlfmt" },

        -- "yaml",
        -- "markdown",
        -- "graphql",
        -- "md",
        -- "txt",
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
}
