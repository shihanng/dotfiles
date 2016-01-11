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
set clipboard+=unnamed

" Encodings.
set fileencoding=utf-8 " When file is saved.
set encoding=utf-8 " For displaying.

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
syntax enable
set background=dark
" Solarized.
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized
" Prevent tab and trail listchars to have highlight in Solarized scheme.
autocmd ColorScheme solarized :hi! link SpecialKey NonText

" SPELLCHECK
" ==========
" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Set region to British English
set spelllang=en

" SWAP FILES
" ==========
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" MOUSE
" =====
set mouse=a
" SWAP FILES
" ==========
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" MOUSE
" =====
set mouse=a
