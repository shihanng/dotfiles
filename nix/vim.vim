" ============================= Basic Configuration ============================
let g:mapleader = ','
set clipboard+=unnamedplus " Allow copy-paste from system clipboard
set number relativenumber
nnoremap <leader>% :source $MYVIMRC<CR> " Reload
noremap <leader>jq :%!jq '.'<cr>
noremap <leader>pg :%!pg_format -b - <cr>
nmap <silent> <leader>s :set spell!<CR> " Toggle spell checking on and off with `,s`

" Show tab and space
set list
set listchars=tab:‣\ ,trail:·


" =================================== Beautify =================================
set encoding=utf8

if has('termguicolors')
 set termguicolors
endif

syntax enable
colorscheme nord


" ============================== NERDTree settings =============================
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
autocmd BufEnter * lcd %:p:h " Set working directory to current file's directory.
let g:NERDTreeQuitOnOpen=1 " Close NERDTree when open a node.


" ======================== vim-nerdtree-syntax-highlight =======================
" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight#mitigating-lag-issues
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name


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


" =================================== coc-fzf ==================================
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }


" =================================== airline ==================================
let g:airline_powerline_fonts = 1


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
command! -nargs=0 Format :call CocAction('format')
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport') " For Go


" =============================== vim-go settings ==============================
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_extra_types = 1

" Disable the following in favor of Coc
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_fmt_autosave = 0

nmap <leader>t <Plug>(go-test)
nmap <Leader>c <Plug>(go-coverage-toggle)


" ==================================== emmet ===================================
let g:user_emmet_install_global = 1
let g:user_emmet_mode='a'
