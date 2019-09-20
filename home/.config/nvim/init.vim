call plug#begin('~/.local/share/nvim/plugged')

" ==================================== Themes ==================================
Plug 'arcticicestudio/nord-vim'

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
