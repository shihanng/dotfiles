setlocal foldmethod=syntax
setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

augroup go
    autocmd!
    autocmd BufNewFile normal zR
augroup END


" ==================================== vim-go ==================================
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_extra_types = 1

" Disable this to use vim-lsp
let g:go_def_mapping_enabled = 0
let g:go_gocode_propose_builtins = 0
let g:go_gocode_propose_source = 0

let g:go_auto_type_info = 1

let g:go_addtags_transform = 'snakecase'

let g:go_fmt_command = 'goimports'

let g:go_snippet_engine = 'neosnippet'

let g:go_info_mode = 'guru'

let g:go_fmt_fail_silently = 1
let g:go_list_type = 'quickfix'
let g:go_statusline_duration = 10000
let g:go_metalinter_deadline = '5s'
let g:go_metalinter_enabled = [
      \ 'deadcode', 'errcheck', 'gosec', 'goconst', 'golint', 'gosimple',
      \ 'gotype', 'ineffassign', 'interfacer', 'staticcheck', 'structcheck',
      \ 'unconvert', 'varcheck', 'vet', 'vetshadow', 'goimports'
      \ ]

noremap <leader>gt :GoDeclsDir<cr>
nmap <leader>r <Plug>(go-run)
nmap <leader>t <Plug>(go-test)
nmap <Leader>c <Plug>(go-coverage-toggle)
nmap <leader>gm <Plug>(go-metalinter)
