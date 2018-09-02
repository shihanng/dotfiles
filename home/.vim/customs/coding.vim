" =================================== Folding ==================================
set foldmethod=syntax
set foldlevelstart=20

" Enable folding with the spacebar
nnoremap <space> za


" ===================================== ALE ====================================
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:airline#extensions#ale#enabled = 1

let g:ale_sign_column_always = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0

nmap <silent> <leader>] <Plug>(ale_previous_wrap)
nmap <silent> <leader>[ <Plug>(ale_next_wrap)

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_linters = {'go': ['gometalinter', 'go build']}
let g:ale_go_gometalinter_options = '
   \ --aggregate
   \ --disable=gas
   \ --disable=gotype
   \ --enable=test
   \ --enable=golint
   \ --enable=errcheck
   \ --enable=vet
   \ --enable=goimports
   \ --sort=line
   \ --fast
   \ --tests
   \ --vendor
   \ '
let g:ale_fix_on_save = 1

" =================================== deoplete =================================
let g:deoplete#omni_patterns = {}
let g:deoplete#enable_at_startup = 1
set completeopt+=noselect
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
call deoplete#initialize()


" ================================== neosnippet ================================
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:neosnippet#snippets_directory = [
            \'~/.vim/plugged/neosnippet-snippets',
            \'~/.vim/plugged/vim-snippets',
            \'~/.vim/snippets',
            \]

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


" Close quickfix
nnoremap <leader>qc :cclose<CR> ""

" Close location
nnoremap <leader>lc :lclose<CR>

" =========================== " LanguageClient-neovim ==========================
" Required for operations modifying multiple buffers like rename.
set hidden

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <leader>lf :call LanguageClient_textDocument_documentSymbol()<CR>

let g:LanguageClient_serverCommands = {
    \ 'go': ['go-langserver'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ }
