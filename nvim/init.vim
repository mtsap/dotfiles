" Themes to try Gruvbox, ayu, nord, palenight, vim-one (leave it for the end)
call plug#begin()
" Coloschemes
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
"-------------
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank' 
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'yuezk/vim-js'
"Plug 'neovim/node-host', { 'do': 'npm install' }
"Plug 'billyvg/tigris.nvim', { 'do': './install.sh' }
call plug#end()
syntax on
let mapleader="\<tab>"
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu rnu
set nowrap
set smartcase 
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set hlsearch
set incsearch
set updatetime=300
set shortmess+=c
"set signcolumn=yes
set timeoutlen=500
set clipboard=unnamedplus
filetype plugin on
set wildmenu
set colorcolumn=80
highlight colorcolumn ctermbg=lightgrey 
set cmdheight=5
" onehalfdark config
set t_Co=256
if exists('+termguicolors')
  "let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  "let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic = '1'
let g:gruvbox_number_column='bg1'
let g:gruvbox_italicize_strings='1'
colorscheme gruvbox

" Remove newbie crutches in Insert Mode
"inoremap <Down> <Nop>
"inoremap <Left> <Nop>
"inoremap <Right> <Nop>
"inoremap <Up> <Nop>

" Remove newbie crutches in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

" Remove newbie crutches in Visual Mode
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" General binding and unbindings
map s <Nop>
map <S-s> <Nop>

" Move between panes
nnoremap <silent> <leader>l :bn<CR>
nnoremap <silent> <leader>h :bp<CR>

" Windows
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" Tab to move up and down to autocomplete list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Go to definition Coc commnands
nmap <silent> <leader>gd :vsp<CR><Plug>(coc-definition)
nmap <silent> <leader>gu <Plug>(coc-references)

" yank highlight config
highlight HighlightedyankRegion ctermbg=black ctermfg=yellow

source $HOME/.config/nvim/airline.vim
source $HOME/.config/nvim/nerdtree.vim
source $HOME/.config/nvim/fzf.vim
source $HOME/.config/nvim/ale.vim

