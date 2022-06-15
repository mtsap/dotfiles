require('telescope').load_extension('fzf')
require('telescope').load_extension('media_files')

require'telescope'.setup {
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg", "mp4", "pdf"},
      find_cmd = "rg" -- find command (defaults to `fd`)
    }
  },
}

local map = vim.api.nvim_set_keymap

options = { noremap = true , silent=true}

map('n', '<leader>ff', ':Telescope find_files<cr>', options)
map('n', '<leader>fbb', ':Telescope buffers<cr>', options)
map('n', '<leader>fg', ':Telescope live_grep<cr>', options)
map('n', '<leader>fc', ':Telescope git_commits<cr>', options)
map('n', '<leader>fb', ':Telescope git_branches<cr>', options)
map('n', '<leader>fcc', ':Telescope git_bcommits<cr>', options)
map('n', '<leader>fm', ':Telescope media_files<cr>', options)

