" =================================== nerdtree =================================
augroup nerdtree
    " Open NERDTree when vim starts with no file was specified.
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd BufEnter * lcd %:p:h " Set working directory to current file's directory.

    " Close vim if only window left open is NERDTree.
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END

" Open NERDTree with C-n.
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen=1 " Close NERDTree when open a node.

let g:rooter_manual_only = 1

" ===================================== fzf ====================================
nmap <C-p> :Files<CR>
nmap <C-g> :GFiles<CR>
nmap <C-b> :Buffers<CR>
nmap <leader>p :Rg<space>
nmap <leader>o :exec 'Rooter' <bar> :Rg<space>
nnoremap <leader>j :exec "Rooter" <bar> :Rg<space><c-r><c-w><CR>
nnoremap <leader>k :Rg<space>"\b"<c-r><c-w>"\b"<CR>
nnoremap <leader>cd :Rooter"<CR>

" :Pt something /path
command! -bang -nargs=* Pt
            \ call fzf#vim#grep(
            \   'pt --color --column -e '
            \ . <q-args>, 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)
