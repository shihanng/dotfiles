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
Plug 'christoomey/vim-tmux-navigator'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" ============================== Text manipulation =============================
Plug 'tpope/vim-surround'
Plug 'haya14busa/is.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'jiangmiao/auto-pairs'

" ==================================== coding ==================================
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

" elm
Plug 'andys8/vim-elm-syntax'

" coc.nvim
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'buoto/gotests-vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Terraform
Plug 'hashivim/vim-hashicorp-tools'

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
set number relativenumber
nnoremap <leader>% :source $MYVIMRC<CR> " Reload
noremap <leader>jq :%!jq '.'<cr>
noremap <leader>pg :%!pg_format -b - <cr>


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


" ==================================== Search ==================================
" Find and replace (by Nick Janetakis)
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" SEARCH
set ignorecase
set hlsearch
set incsearch
set smartcase
set gdefault " s/<find>/<replace>/g -- g is auto-inserted.


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
autocmd BufEnter * lcd %:p:h " Set working directory to current file's directory.
let g:NERDTreeQuitOnOpen=1 " Close NERDTree when open a node.


" ================================= Coc settings ===============================
nmap <silent> gd <Plug>(coc-definition)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif


" =============================== vim-go settings ==============================
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_extra_types = 1
let g:gotests_template_dir = ""

" Disable the following in favor of Coc
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_fmt_autosave = 0

nmap <leader>t <Plug>(go-test)
nmap <Leader>c <Plug>(go-coverage-toggle)


" ===================================== yaml ===================================
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


" ================================== Terraform =================================
let g:terraform_fmt_on_save=1
let g:terraform_align=1
let g:terraform_fold_sections=0
let g:terraform_remap_spacebar=1
let g:terraform_commentstring='//%s'
