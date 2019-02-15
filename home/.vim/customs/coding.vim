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
\   'javascript': ['prettier', 'eslint'],
\}
let g:ale_linters = {
\   'go': ['gometalinter', 'go build'],
\   'javascript': ['flow'],
\}
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
let g:ale_javascript_prettier_use_local_config = 1

" Turn off for vim-lsp
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 'never'


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

" =================================== vim-lsp ==================================
" Required for operations modifying multiple buffers like rename.
set hidden

let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

nnoremap <silent> K :LspHover<CR>
nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> <F2> :LspRename<CR>
nnoremap <leader>lf :LspDocumentSymbol<CR>

if executable('bingo')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'bingo',
        \ 'cmd': {server_info->['bingo', '--mode', 'stdio', '--logfile', '/tmp/lspserver.log','--trace', '--pprof', ':6060']},
        \ 'whitelist': ['go'],
        \ })
endif

if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'javascript support using typescript-language-server',
      \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
      \ 'whitelist': ['javascript', 'javascript.jsx']
      \ })
endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {'pydocstyle': {'enabled': v:true}}}}
        \ })
else
        echom "pip install --user 'python-language-server[all]'"
        echom "pip install --user pyls-black"
endif

if executable('docker-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'docker-langserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
        \ 'whitelist': ['dockerfile'],
        \ })
else
        echom "npm install -g dockerfile-language-server-nodejs"
endif

augroup LspEFM
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'efm-langserver-erb',
      \ 'cmd': {server_info->['efm-langserver', '-c=$HOME/.config/efm-langserver/config.yaml']},
      \ 'whitelist': ['eruby', 'markdown'],
      \ })
augroup END

if executable('bash-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
        \ 'whitelist': ['sh'],
        \ })
endif

" ===================== prabirshrestha/asyncomplete-lsp.vim ====================
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
