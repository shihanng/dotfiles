call plug#begin('~/.local/share/nvim/plugged')

" ==================================== Themes ==================================
Plug 'arcticicestudio/nord-vim'

" =============================== File navigation ==============================
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'

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


" =================================== Beautify =================================
set encoding=utf8

if has('termguicolors')
 set termguicolors
endif

syntax enable
colorscheme nord


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


" ================================= FZF settings ===============================
nmap <C-p> :Files<CR>
nmap <C-b> :Buffers<CR>

let g:fzf_layout = { 'down': '~40%' }

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.<q-args>, 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" ============================== NERDTree settings =============================
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
let g:NERDTreeQuitOnOpen=1 " Close NERDTree when open a node.
