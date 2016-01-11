scriptencoding utf-8

call plug#begin()

" Brackets, etc.
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Themes.
Plug 'altercation/vim-colors-solarized'

" Version control.
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" File explorer.
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" Coding.
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plugin 'Shougo/neocomplete'

" Golang.
Plug 'fatih/vim-go'

" Others.
Plug 'tpope/vim-repeat'

" Add plugins to &runtimepath.
call plug#end()

" Python supports.
let g:python3_host_prog = '/usr/bin/python3'

" Source other settings.
for f in split(glob('~/bin/dotfiles/nvim/vimfiles/*.vim'), '\n')
    exe 'source' f
endfor
