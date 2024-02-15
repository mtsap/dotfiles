local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

    -- webdev stuff
    -- b.formatting.prettier.with {
    --     filetypes = {
    --         "javascript",
    --         "typescript",
    --         "css",
    --         "scss",
    --         "html",
    --         -- "json",
    --         "yaml",
    --         -- "markdown",
    --         "graphql",
    --         -- "md",
    --         -- "txt",
    --     },
    -- },
    -- so prettier works only on these filetypes
    -- b.formatting.jq.with {
    --     filetypes = {
    --         "json",
    --     },
    --     command = "jq",
    --     args = { "--indent 1" },
    -- },
    b.diagnostics.eslint_d,
    b.code_actions.eslint_d,

    -- Lua
    -- b.formatting.stylua,

    -- cpp
    -- b.formatting.clang_format,

    --rust
    -- b.formatting.rustfmt,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup {
    debug = true,
    sources = sources,

    on_attach = function(client, bufnr)
        -- if client.supports_method "textDocument/formatting" then
        --     vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        --     vim.api.nvim_create_autocmd("BufWritePre", {
        --         group = augroup,
        --         buffer = bufnr,
        --         callback = function()
        --             -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        --             -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
        --             vim.lsp.buf.format { async = false }
        --         end,
        --     })
        -- end
    end,
}
