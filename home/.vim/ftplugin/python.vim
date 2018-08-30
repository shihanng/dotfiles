" pip install flake8

syntax on
setlocal foldmethod=syntax

setlocal tabstop=8
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

augroup python
    autocmd!
    autocmd BufNewFile normal zR
    autocmd BufWritePre * %s/\s\+$//e
augroup END

let g:SimpylFold_docstring_preview=1
let g:python_highlight_all=1
