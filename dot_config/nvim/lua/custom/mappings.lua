---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

M.mine = {
  n = {

    ["s"] = { "<Nop>", "", opts = { noremap = true, silent = true } },
    ["S-s"] = { "<Nop>", "", opts = { noremap = true, silent = true } },
    ["<Up>"] = { "<Nop>", "", opts = { noremap = true, silent = true } },
    ["<Down>"] = { "<Nop>", "", opts = { noremap = true, silent = true } },
    ["<Left>"] = { "<Nop>", "", opts = { noremap = true, silent = true } },
    ["<Right>"] = { "<Nop>", "", opts = { noremap = true, silent = true } },
    ["<C-d>"] = { "<C-d>zz", "", opts = { noremap = true, silent = true } },
    ["<C-u>"] = { "<C-u>zz", "", opts = { noremap = true, silent = true } },
    ["n"] = { "nzz", "", opts = { noremap = true, silent = true } },
    ["N"] = { "Nzz", "", opts = { noremap = true, silent = true } },
    ["gh"] = { "0", "Start of line", opts = { noremap = true, silent = true } },
    ["gl"] = { "$", "End of line", opts = { noremap = true, silent = true } },
  },
  v = {
    ["<Up>"] = { "<Nop>", "", opts = { noremap = true, silent = true } },
    ["<Down>"] = { "<Nop>", "", opts = { noremap = true, silent = true } },
    ["<Left>"] = { "<Nop>", "", opts = { noremap = true, silent = true } },
    ["<Right>"] = { "<Nop>", "", opts = { noremap = true, silent = true } },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd>Telescope find_files cwd=false <cr>", "Find files (root dir)" },
    ["<leader>fF"] = { "<cmd>Telescope find_files <cr>", "Find files (cwd)" },
    ["<leader>fbb"] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch buffer" },
    ["<leader>f:"] = { "<cmd> Telescope command_history <CR>", "Command History" },
    --grep
    ["<leader>fg"] = { "<cmd> Telescope live_grep cwd=false <CR>", "Live grep (root dir)" },
    ["<leader>fG"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },

    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

    -- git
    ["<leader>fgc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>fgs"] = { "<cmd> Telescope git_status <CR>", "Git status" },
    --diagnostics
    ["<leader>fd"] = { "<cmd> Telescope diagnostics <CR>", "Diagnostics" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },

    ["<leader>sa"] = { "<cmd>Telescope autocommands<cr>", "Auto Commands" },
    ["<leader>sC"] = { "<cmd>Telescope commands<cr>", "Commands" },
    ["<leader>sk"] = { "<cmd>Telescope keymaps<cr>", "Key Maps" },
    ["<leader>sM"] = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    ["<leader>sw"] = { "<cmd>Telescope grep_string<cr>", "Word (root dir)" },
    ["<leader>sW"] = { "<cmd>Telescope grep_string cwd=false<cr>", "Word (cwd)" },
  },
}

M.tmuNavigator = {
  n = {

    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", "Go to left window" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>", "Go to down window" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>", "Go to up window" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", "Go to right window" },
  },
}

-- more keybinds!

return M
