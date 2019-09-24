call plug#begin('~/.local/share/nvim/plugged')

" ==================================== Themes ==================================
Plug 'arcticicestudio/nord-vim'

" ============================== Text manipulation =============================
Plug 'tpope/vim-surround'
Plug 'haya14busa/is.vim'
Plug 'nelstrom/vim-visual-star-search'

" ==================================== coding ==================================
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'

" elm
Plug 'andys8/vim-elm-syntax'

" coc.nvim
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}

call plug#end()


" ===================================== Coc ====================================
command! -nargs=0 Format :call CocAction('format')
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport') " For Go


" ============================= Basic Configuration ============================
let g:mapleader = ','
set clipboard+=unnamedplus " Allow copy-paste from system clipboard
nnoremap <leader>% :source $MYVIMRC<CR> " Reload


" ============================= create this with ,ch ===========================
noremap <leader>ch :center 80<cr>hhv0r=A<space><esc>40A=<esc>:Commentary<cr><esc>81<bar>D


" ================================= Indentations ===============================
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab


" ===================================== Undo ===================================
if has('persistent_undo')
    set undolevels=5000 " Save a lot of back-history
    set undofile " Actually switch on persistent undo
endif


" ================================== Swap files ================================
set undodir=~/.local/share/vim/undo//
set backupdir=~/.local/share/vim/backup//
set directory=~/.local/share/vim/swp//


" ===================== Find and replace (by Nick Janetakis) ===================
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>
