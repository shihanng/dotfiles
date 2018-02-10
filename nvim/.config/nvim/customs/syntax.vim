" Folding
" =======
set foldmethod=syntax
set foldlevelstart=20

" Enable folding with the spacebar
nnoremap <space> za

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:airline#extensions#ale#enabled = 1

let g:ale_sign_column_always = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0

nmap <silent> <leader>] <Plug>(ale_previous_wrap)
nmap <silent> <leader>[ <Plug>(ale_next_wrap)

" Close quickfix
nnoremap <leader>qc :cclose<CR> ""

" Close location
nnoremap <leader>lc :lclose<CR>
