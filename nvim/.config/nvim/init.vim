scriptencoding utf-8

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()

" ==================================== Themes ==================================
Plug 'dracula/vim'
Plug 'ryanoasis/vim-devicons'

" ================================ File explorer ===============================
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-eunuch'

" ===================================== Git ====================================
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" ============================== Text manipulation =============================
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Coding.
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'AndrewRadev/splitjoin.vim'
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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" JSON.
Plug 'elzr/vim-json'

Plug 'direnv/direnv.vim'

Plug 'hashivim/vim-hashicorp-tools'

" ===================================== fzf ====================================
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Add plugins to &runtimepath.
call plug#end()

" Python supports.
let g:python_host_prog = expand($HOME) . '/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = expand($HOME) . '/.pyenv/versions/neovim3/bin/python'

" Source other settings.
for s:f in split(glob('$HOME/.config/nvim/customs/*.vim'), '\n')
    exe 'source' s:f
endfor
