" GOLANG (See: https://github.com/fatih/vim-go)
" =============================================
let g:go_highlight_functions = 1         " ⎤
let g:go_highlight_methods = 1           " ⎟ Better highlighting.
let g:go_highlight_structs = 1           " ⎟
let g:go_highlight_operators = 1         " ⎟
let g:go_highlight_build_constraints = 1 " ⎦
let g:go_fmt_command = "goimports"

" Syntastic.
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['go'] }
