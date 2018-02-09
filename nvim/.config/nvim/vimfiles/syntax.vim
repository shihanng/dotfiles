" Folding
" =======
set foldmethod=syntax
set foldlevelstart=20
autocmd Syntax go setlocal foldmethod=syntax
autocmd Syntax python setlocal foldmethod=indent
autocmd Syntax go,python normal zR
" Enable folding with the spacebar
nnoremap <space> za
let g:SimpylFold_docstring_preview=1 " For Python.
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:airline#extensions#ale#enabled = 1

let g:ale_sign_column_always = 1

" " Write this in your vimrc file
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1

let g:ale_linters = {'go': ['gometalinter']}
let g:ale_go_gometalinter_executable = '$HOME/go/bin/gometalinter'
" let g:ale_go_gometalinter_options = '
"   '
"   \ --aggregate
"   \ --disable=gas
"   \ --enable=test
"   \ --enable=vet
"   \ --enable=golint
"   \ --enable=goimports
"   \ --sort=line
"   \ --tests
"   \ --vendor
let g:ale_open_list = 1
" Set this if you want to.
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
let g:ale_keep_list_window_open = 1

