" SHORTCUTS
" =========
let mapleader = ","

" SEARCH
" ======
set ignorecase
set hlsearch
set incsearch
set smartcase
set gdefault " s/<find>/<replace>/g -- g is auto-inserted.
nmap <silent> <leader>h :nohl<CR>

" WINDOWS
" =======
"set winwidth=84    " ⎤
"set winheight=5    " ⎟ Auto resize windows.
"set winminheight=5 " ⎟
"set winheight=999  " ⎦

" EDITING
" =======
" Indentations.
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set clipboard+=unnamedplus " Copy/paste
set textwidth=79
set fileformat=unix

au BufNewFile,BufRead *.go
    \ setlocal noexpandtab
    \ tabstop=4
    \ shiftwidth=4

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ softtabstop=2
    \ shiftwidth=2

au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ shiftwidth=4
    \ expandtab
    \ softtabstop=4

au BufNewFile,BufRead *.md
    \ set tw=0
    \ set wrapmargin=0

" Encodings.
set fileencoding=utf-8 " When file is saved.
if !has('nvim')
    set encoding=utf-8 " For displaying.
endif

" Brackets.
set showmatch

" Visual.
set list
set listchars=tab:‣\ ,trail:·

set number
set cursorline
set cc=80

" Others.
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]   " Backspace and cursor keys wrap too

" COLOR SCHEME
" ============
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
colorscheme OceanicNext

" SPELLCHECK
" ==========
" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Set region to British English
set spelllang=en

" SWAP FILES
" ==========
set undodir=~/.local/share/nvim/undo//
set backupdir=~/.local/share/nvim/backup//
set directory=~/.local/share/nvim/swap//

" MOUSE
" =====
set mouse=a

" QUICKFIX LIST (used by vim-go)
" ==============================
map <leader>qn :cn<CR>
map <leader>qp :cp<CR>
nnoremap <leader>qc :cclose<CR>

" LOCATION LIST (used by syntastic)
" =================================
nnoremap <leader>lc :lclose<CR>

" OTHERS
" ======
nmap <F8> :TagbarOpenAutoClose<CR>
nnoremap <leader>% :source $MYVIMRC<CR>
set autowrite
