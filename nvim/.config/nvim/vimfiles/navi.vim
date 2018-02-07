" NERDTREE
" ========

" Open NERDTree when vim starts with no file was specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufEnter * lcd %:p:h " Set working directory to current file's directory.

" Open NERDTree with C-n.
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1 " Close NERDTree when open a node.

" Close vim if only window left open is NERDTree.
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>p :Pt<space>
nnoremap K :Pt<space>"\b"<c-r><c-w>"\b"<CR>

" :Pt something /path
command! -bang -nargs=* Pt
  \ call fzf#vim#grep(
  \   'pt --color --column -e '
  \ . <q-args>, 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" NumberToggle
" ============
let g:NumberToggleTrigger="<c-m>"
