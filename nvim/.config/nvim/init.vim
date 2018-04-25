scriptencoding utf-8

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
call plug#begin()

" ================================ File explorer ===============================
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'direnv/direnv.vim'

" ==================================== Themes ==================================
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" ===================================== Git ====================================
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" ============================== Text manipulation =============================
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'triglav/vim-visual-increment'
Plug 'terryma/vim-multiple-cursors'

" ==================================== Coding ==================================
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'w0rp/ale'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'majutsushi/tagbar'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets' " Snippets collections.
Plug 'honza/vim-snippets' " Snippets collections.

" Golang.
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go', { 'do': 'make'}

" JavaScript.
Plug 'jaxbot/browserlink.vim'
Plug 'pangloss/vim-javascript'

" Python.
Plug 'tmhedberg/SimpylFold'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'hdima/python-syntax'

" HTML
Plug 'mattn/emmet-vim'

" Ruby.
Plug 'fishbullet/deoplete-ruby'

" Markdown / Note.
Plug 'tpope/vim-markdown'
Plug 'JamshedVesuna/vim-markdown-preview'

" JSON.
Plug 'elzr/vim-json'

" TeX.
Plug 'lervag/vimtex'

" Terraform, etc.
Plug 'hashivim/vim-hashicorp-tools'

" Add plugins to &runtimepath.
call plug#end()

" Python supports.
let g:python_host_prog = expand($HOME) . '/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = expand($HOME) . '/.pyenv/versions/neovim3/bin/python'
let g:ruby_host_prog = '~/.rbenv/versions/2.4.3/bin/neovim-ruby-host'

" Source other settings.
for s:f in split(glob('$HOME/.config/nvim/customs/*.vim'), '\n')
    exe 'source' s:f
endfor
