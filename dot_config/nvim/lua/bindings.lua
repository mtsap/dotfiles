local map = vim.api.nvim_set_keymap
-- leader
--vim.api.nvim_set_keymap('', 'CTRL-I', '<Nop>', { noremap = true, silent = true })
--vim.g.mapleader = '\t'
vim.g.mapleader = ' '
--vim.g.maplocalleader = 'CTRL-I'

options = { noremap = true , silent=true }

map('n', 's', '<Nop>', options)
map('n', '<S-s>','<Nop>', options)
map('n', '<Up>','<Nop>', options)
map('n', '<Down>','<Nop>', options)
map('n', '<Left>','<Nop>', options)
map('n', '<Right>','<Nop>', options)
map('v', '<Up>','<Nop>', options)
map('v', '<Down>','<Nop>', options)
map('v', '<Left>','<Nop>', options)
map('v', '<Right>','<Nop>', options)

-- Pane navigation
map('n', '<leader>l',':bn<CR>', options)
map('n', '<leader>h',':bp<CR>', options)

-- Windows navigation
map('n', 'ss',':split<Return><C-w>w', options)
map('n', 'sv',':vsplit<Return><C-w>w', options)
map('n', '<C-h>','<C-w>h', options)
map('n', '<C-j>','<C-w>j', options)
map('n', '<C-k>','<C-w>k', options)
map('n', '<C-l>','<C-w>l', options)

-- Quick list keybindings
map('n', '<leader>c',':cclose<CR>', options)
map('n', '<Up>',':cp<CR>', options)
map('n', '<Down>',':cn<CR>', options)

-- Hop
map('n', 's',':HopWord<CR>', options)
-- tree hopper
map('n', '<leader>s',':<C-U>lua require(\'tsht\').nodes()<CR>', options)
map('v', '<leader>s',':<C-U>lua require(\'tsht\').nodes()<CR>', options)



