" GOLANG (See: https://github.com/fatih/vim-go)
" =============================================
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_extra_types = 1
let g:go_auto_type_info = 1

let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"

autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

" Run :GoBuild or :GoTestCompile based on the go file.
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" Go Metalinter.
let g:go_list_type = "quickfix"
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'goimports']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['errcheck', 'vet', 'golint', 'goimports']
let g:go_metalinter_deadline = "5s"
let g:go_snippet_engine = "neosnippet"

let g:go_autodetect_gopath = 0

au FileType go nmap <leader>gt :GoDeclsDir<cr>
