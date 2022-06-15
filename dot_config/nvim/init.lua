-- keep it at the top so it is not overidden by plugins
vim.opt.termguicolors = true

require('bindings')
require('fugitive-config')
require('nvim-tree-config')
require('telescope-config')
require('gruvbox-material-config')
require('treesitter-config')
require('lsp-config')
require('autopairs-config')
require('devicons-config')
require('formatter-config')
require('trouble-config')
require('cmp-config')
require('indent-config')
require('feline-config')
require('bufferline-config')
require('dressing-config')


require('packer').startup(function(use)
  use {
   "goolord/alpha-nvim",
   config = function()
    require("startup").setup()
   end,
  }
  use {
   "SmiteshP/nvim-gps",
   requires = "nvim-treesitter/nvim-treesitter"
  }
  use "navarasu/onedark.nvim"
  use "christoomey/vim-tmux-navigator"
  use "tpope/vim-fugitive"
  use "junegunn/gv.vim"
  use "kyazdani42/nvim-web-devicons"
  use {
     'kyazdani42/nvim-tree.lua',
     requires = 'kyazdani42/nvim-web-devicons',
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
   'nvim-telescope/telescope.nvim',
   requires = { {'nvim-lua/plenary.nvim'} }
  }
  use "nvim-lua/plenary.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "tpope/vim-commentary"
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use "tpope/vim-surround"
  use "sainnhe/gruvbox-material"

  use "neovim/nvim-lspconfig"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"
  use "ray-x/cmp-treesitter"
  use "hrsh7th/cmp-nvim-lsp-signature-help"
  use {'David-Kunz/cmp-npm',
  requires = {
   'nvim-lua/plenary.nvim'
  }}
  use "onsails/lspkind-nvim"
  use "windwp/nvim-autopairs"

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'mfussenegger/nvim-ts-hint-textobject' }
  use "mhartington/formatter.nvim"
  use "glepnir/lspsaga.nvim"
  use {
   "folke/trouble.nvim",
   requires = "kyazdani42/nvim-web-devicons",
  }

  use "lukas-reineke/indent-blankline.nvim"
  use 'norcalli/nvim-colorizer.lua'
  use 'p00f/nvim-ts-rainbow'
  use 'feline-nvim/feline.nvim'
  use {
   'lewis6991/gitsigns.nvim',
   config = function()
     require('gitsigns').setup()
   end
  }
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons'}
  use {
  'phaazon/hop.nvim',
  branch = 'v1', -- optional but strongly recommended
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  end
  }
  use {'stevearc/dressing.nvim'}
  use {'mrjones2014/legendary.nvim'}
  use {
   'j-hui/fidget.nvim',
   config = function()
     require('fidget').setup()
   end
  }
  use {
    'stonelasley/flare.nvim',
    config = function() require('flare').setup{
      enabled = true, -- disable highlighting
      hl_group = "Search", 
    } end
  }
end)


--require('onedark').setup()

local fn = vim.fn
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local execute = vim.api.nvim_command

execute(":syntax on")
execute(":filetype plugin on")
-- global options
o.swapfile = false
o.smartcase = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.scrolloff = 12
o.errorbells = false
o.backup = false
o.writebackup = false
o.undodir = "/home/mtsap/.vim/undodir"
o.undofile = true
o.hlsearch = true
o.incsearch = true
o.updatetime = 300
o.timeout = true
o.timeoutlen = 500
o.clipboard = "unnamedplus"
o.wildmenu = false
o.wildmode="longest:list,full"
o.wildoptions = "pum" 
o.cmdheight = 5
o.background = "dark"
o.completeopt = "menu,menuone,noselect"
o.laststatus = 3
--o.t_Co = "256"


-- window-local options
wo.number = false
wo.wrap = false
wo.number = true
wo.relativenumber = true
wo.colorcolumn = "80"
execute(":highlight colorcolumn ctermbg=lightgrey")

-- buffer-local options
o.expandtab = true
bo.expandtab = true
bo.tabstop = 2
o.tabstop = 2
bo.softtabstop = 2
o.softtabstop = 2
bo.shiftwidth = 2
o.shiftwidth = 2
bo.smartindent = true
o.smartindent = true

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.json,*.rs,*.lua,*.ts FormatWrite
augroup END
]], true)

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

execute('let g:gruvbox_material_background = \'hard\'' )
execute('let g:gruvbox_material_palette = \'original\'' )
execute('colorscheme gruvbox-material')
