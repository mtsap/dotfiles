local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

    -- Override plugin definition options
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "nvimtools/none-ls.nvim",
                config = function()
                    require "custom.configs.null-ls"
                end,
            },
        },
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end, -- Override to setup mason-lspconfig
    },
    -- {
    --   "simrat39/rust-tools.nvim",
    --   dependencies = "neovim/nvim-lspconfig",
    --   ft = "rust",
    --   opts = function()
    --     return "custom.configs.rust-tools"
    --   end,
    --   config = function(_, opts)
    --     require("rust-tools").setup(opts)
    --   end,
    -- },

    -- override plugin configs
    {
        "williamboman/mason.nvim",
        opts = overrides.mason,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
    },

    -- Install a plugin
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        opts = function()
            return require "custom.configs.telescope"
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute { toggle = true, dir = require("lazyvim.util").get_root() }
                end,
                desc = "Explorer NeoTree (root dir)",
            },
            {
                "<leader>fE",
                function()
                    require("neo-tree.command").execute { toggle = true, dir = vim.loop.cwd() }
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            { "<leader><tab><tab>", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
            { "<leader><tab>",      "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
        },
        deactivate = function()
            vim.cmd [[Neotree close]]
        end,
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require "neo-tree"
                end
            end
        end,
        opts = {
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = {
                    enabled = true,
                },
                filtered_items = {
                    visible = false,
                    hide_gitignored = true,
                },
            },
            window = {
                mappings = {
                    ["<space>"] = "none",
                },
            },
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
            },
        },
    },

    {
        { "tpope/vim-surround", lazy = false },
    },
    {
        { "christoomey/vim-tmux-navigator", lazy = false },
    },
    {
        "folke/trouble.nvim",
        lazy = false,
        cmd = { "Trouble", "TroubleClose", "TroubleRefresh", "TroubleToggle" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- To make a plugin not be loaded
    {
        "nvim-tree/nvim-tree.lua",
        enabled = false,
    },
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            {
                "<leader>gg",
                "<cmd>Git<CR>",
                {
                    noremap = true,
                    silent = true,
                },
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-ui-select.nvim",
            -- "nvim-telescope/telescope-fzf-native.nvim",
            -- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
        opts = {
            defaults = {},
            extensions_list = { "themes", "terms", "ui-select" },
            extensions = {
                ["ui-select"] = { require("telescope.themes").get_dropdown() },
            },
        },
    },
    {
        "gennaro-tedesco/nvim-jqx",
        ft = { "json", "yaml" },
    },
    {
        "theKnightsOfRohan/csvlens.nvim",
        dependencies = {
            "akinsho/toggleterm.nvim",
        },
        config = true,
        lazy = false,
    },
    {
        "cameron-wags/rainbow_csv.nvim",
        config = true,
        ft = {
            "csv",
            "tsv",
            "csv_semicolon",
            "csv_whitespace",
            "csv_pipe",
            "rfc_csv",
            "rfc_semicolon",
        },
        cmd = {
            "RainbowDelim",
            "RainbowDelimSimple",
            "RainbowDelimQuoted",
            "RainbowMultiDelim",
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-jest",
            "mfussenegger/nvim-dap",
        },

        keys = {
            {
                "<leader>tt",
                function()
                    require("neotest").run.run_last()
                end,
                desc = "Run the nearest test",
            },
            {
                "<leader>tg",
                function()
                    require("neotest").run.run(vim.fn.expand "%")
                end,
                desc = "Run the nearest test",
            },
        },
        config = function()
            require("neotest").setup {
                adapters = {
                    require "neotest-jest" {
                        jestCommand = "npm test --",
                        jestConfigFile = "jest.config.ts",
                        env = { CI = true },
                        cwd = function(path)
                            return vim.fn.getcwd()
                        end,
                    },
                    quickfix = {
                        enabled = false,
                        open = false,
                    },
                    output_panel = {
                        open = "rightbelow vsplit | resize 30",
                    },
                    status = {
                        virtual_text = false,
                        signs = true,
                    },
                },
            }
        end,
    },
    {
        "LunarVim/bigfile.nvim",
        lazy = false,
        config = function()
            require("bigfile").setup {
                filesize = 6, -- size of the file in MiB, the plugin round file sizes to the closest MiB
                pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
                features = { -- features to disable
                    "indent_blankline",
                    "illuminate",
                    -- "lsp",
                    "treesitter",
                    "syntax",
                    "matchparen",
                    "vimopts",
                    -- "filetype",
                },
            }
        end,
    },
    {
        "folke/noice.nvim",
        lazy = false,
        opts = {},
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        config = function()
            vim.api.nvim_set_hl(0, "MineRedBg", { bg = "#fb4934", fg = "#282828" })
            vim.api.nvim_set_hl(0, "MineRedFg", { bg = "#00ff00", fg = "#0000ff" })
            vim.api.nvim_set_hl(0, "MineYellowBg", { bg = "#fabd2f", fg = "#282828" })
            vim.api.nvim_set_hl(0, "MineBlackBg", { bg = "#282828", fg = "#282828" })
            vim.api.nvim_set_hl(0, "MineGreyBg", { bg = "#232323", fg = "#fbf1c7" })
            vim.api.nvim_set_hl(0, "MineGreyBg2", { bg = "#232323", fg = "#fb4934" })

            require("noice").setup {
                views = {
                    cmdline_popupmenu = {
                        border = {
                            padding = { 0, 2 },
                        },
                        position = {
                            row = 7,
                            col = "50%",
                        },
                        win_options = {
                            winhighlight = { Normal = "MineGreyBg", FloatBorder = "MineBlackBg", CursorLine = "MineRedBg" },
                        },
                    },
                },
                presets = {
                    command_palette = true,
                    long_message_to_split = true,
                },
                cmdline = {
                    enabled = true, -- enables the Noice cmdline UI
                    view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
                    opts = {
                        border = {
                            padding = { 1, 2 },
                        },
                        position = {
                            row = 5,
                            col = "50%",
                        },
                        win_options = {
                            winhighlight = "NoiceCmdlineIcon:MineGreyBg2,Cursor:MineYellowBg,FloatBorder:MineBlackBg,Title:MineRedBg,Normal:MineGreyBg",
                        },
                    }, -- global options for the cmdline. See section on views
                    ---@type table<string, CmdlineFormat>
                    format = {
                        -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
                        -- view: (default is cmdline view)
                        -- opts: any options passed to the view
                        -- icon_hl_group: optional hl_group for the icon
                        -- title: set to anything or empty string to hide
                        cmdline = { pattern = "^:", icon = "", lang = "vim" },
                        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                        lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
                        help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                        input = {}, -- Used by input()
                        -- lua = false, -- to disable a format, set to `false`
                    },
                },
                messages = {
                    -- NOTE: If you enable messages, then the cmdline is enabled automatically.
                    -- This is a current Neovim limitation.
                    enabled = true,    -- enables the Noice messages UI
                    view = "mini",     -- default view for messages
                    view_error = "notify", -- view for errors
                    view_warn = "notify", -- view for warnings
                    view_history = "messages", -- view for :messages
                    view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
                },
                popupmenu = {
                    enabled = true, -- enables the Noice popupmenu UI
                    view = "popupmenu",

                    -- global options for the cmdline. See section on views
                    ---@type 'nui'|'cmp'
                    backend = "nui", -- backend to use to show regular cmdline completions
                    ---@type NoicePopupmenuItemKind|false
                    -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
                    kind_icons = {}, -- set to `false` to disable icons
                },
                lsp = {
                    hover = {
                        enabled = false,
                    },
                    signature = {
                        enabled = false,
                    },
                },
            }
        end,
    },
    {
        "stevearc/conform.nvim",
        lazy = false,
        config = function()
            require "custom.configs.conform"
        end,
    },

    -- All NvChad plugins are lazy-loaded by default
    -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
    -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
    -- {
    --   "mg979/vim-visual-multi",
    --   lazy = false,
    -- }
}

return plugins
