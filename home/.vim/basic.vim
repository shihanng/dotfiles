set encoding=utf-8
set fileencoding=utf-8

scriptencoding utf-8

filetype plugin on
filetype plugin indent on

" SHORTCUTS
" =========
let g:mapleader = ','

" SEARCH
" ======
set ignorecase
set hlsearch
set incsearch
set smartcase
set gdefault " s/<find>/<replace>/g -- g is auto-inserted.
nnoremap <silent> <BS> :nohl<CR>

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
set clipboard=unnamedplus " Copy/paste
set textwidth=79
set fileformat=unix

au FileType html,css
    \ setlocal tabstop=2 softtabstop=2 shiftwidth=2

" Brackets.
set showmatch

" Visual.
set list
set listchars=tab:‣\ ,trail:·

set number
set cursorline
set colorcolumn=80

" Others.
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]   " Backspace and cursor keys wrap too


" SPELLCHECK
" ==========
" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Set region to British English
set spelllang=en

" Use persistent undo: Undo will be available when file is reopen.
if has('persistent_undo')
    " Save a lot of back-history...
    set undolevels=5000

    " Actually switch on persistent undo
    set undofile
endif

" SWAP FILES
" ==========
set undodir=~/.local/share/vim/undo//
set backupdir=~/.local/share/vim/backup//
set directory=~/.local/share/vim/swap//

" MOUSE
" =====
set mouse=a

" ============================= create this with ,ch ===========================
noremap <leader>ch :center 80<cr>hhv0r=A<space><esc>40A=<esc>:Commentary<cr><esc>81<bar>D

noremap <leader>jq :%!jq '.'<cr>
noremap <leader>cm :verbose map 

noremap <F8> :TagbarOpenAutoClose<CR>

nnoremap <leader>% :source $MYVIMRC<CR>
set autowrite
