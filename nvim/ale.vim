let b:ale_fixers = ['prettier', 'eslint']
let g:ale_sign_column_always = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_list_window_size = 5
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:airline#extensions#ale#enabled = 1
"highlight ALEWarning ctermbg=0 ctermfg=yellow
"highlight ALEError ctermbg=0 ctermfg=red 
"highlight ALEWarningSign ctermbg=0 ctermfg=yellow
"highlight ALEErrorSign ctermbg=0 ctermfg=red
highlight ALEErrorSign guibg=#3c3836 guifg=#fb4934
highlight ALEWarningSign guibg=#3c3836 guifg=#fe8019

nmap <silent> <leader>, <Plug>(ale_previous_wrap)
nmap <silent> <leader>. <Plug>(ale_next_wrap)
