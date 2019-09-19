call plug#begin('~/.local/share/nvim/plugged')

" ==================================== Themes ==================================
Plug 'arcticicestudio/nord-vim'

" ==================================== coding ==================================
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" elm
Plug 'andys8/vim-elm-syntax'

" coc.nvim
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}

call plug#end()

" ===================================== Coc ====================================
command! -nargs=0 Format :call CocAction('format')
