local map = vim.api.nvim_set_keymap
-- leader
--vim.api.nvim_set_keymap('', 'CTRL-I', '<Nop>', { noremap = true, silent = true })

options = { noremap = true , silent=true }
-- Quick list keybindings
map('n', '<leader>gg',':Git<CR>', options)
map('n', '<leader>gh',':0Gclog<CR>', options)
map('n', '<leader>gd',':Gdiff<CR>', options)
map('n', '<leader>ge',':Gedit<CR>', options)
map('n', '<leader>gqq',':Gedit<CR>:cclose<CR>', options)
map('n', '<leader>gps',':Git push<CR>', {noremap = true})
map('n', '<leader>gpl',':Git pull<CR>', {noremap = true})

-- TODO add mappings for diffput //2 //3
