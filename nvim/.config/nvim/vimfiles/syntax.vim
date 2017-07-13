" Syntastics.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

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
let g:syntastic_shell = "/bin/sh" " To work with direnv
