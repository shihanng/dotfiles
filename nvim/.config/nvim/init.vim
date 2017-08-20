scriptencoding utf-8

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
" Brackets, etc.
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Themes.
Plug 'fatih/molokai'
Plug 'ryanoasis/vim-devicons'

" Version control.
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" File explorer.
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-eunuch'

" Coding.
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-dispatch' " Used by vim-go.
Plug 'AndrewRadev/splitjoin.vim' " Used by vim-go.
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets' " Snippets collections.
Plug 'honza/vim-snippets' " Snippets collections.

" JavaScript.
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'wookiehangover/jshint.vim'

" Golang.
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'godoctor/godoctor.vim'
Plug 'jodosha/vim-godebug'

" Others.
Plug 'tpope/vim-repeat'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'godlygeek/tabular'
Plug 'triglav/vim-visual-increment'
Plug 'lervag/vimtex'
Plug 'christoomey/vim-tmux-navigator'
Plug 'yssl/QFEnter'
Plug 'triglav/vim-visual-increment'

" Python.
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim' " Autoindent
Plug 'nvie/vim-flake8'

" Ruby.
Plug 'fishbullet/deoplete-ruby'

" Markdown / Note.
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'jceb/vim-orgmode'

" Status.
Plug 'itchyny/lightline.vim'

" JSON.
Plug 'elzr/vim-json'

Plug 'direnv/direnv.vim'

Plug 'hashivim/vim-hashicorp-tools'

" Add plugins to &runtimepath.
call plug#end()

" Python supports.
let g:python_host_prog = expand($HOME) . '/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = expand($HOME) . '/.pyenv/versions/neovim3/bin/python'

" Source other settings.
for f in split(glob('$HOME/.config/nvim/vimfiles/*.vim'), '\n')
    exe 'source' f
endfor

for f in split(glob('$HOME/.config/nvim/plugins/*.vim'), '\n')
    exe 'source' f
endfor
