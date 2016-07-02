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
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" CTRLP
" =====
" See: chriskempson/vim-tomorrow-them://github.com/ctrlpvim/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 'ra'

" numbertogle
" ===========
let g:NumberToggleTrigger="<c-m>"
