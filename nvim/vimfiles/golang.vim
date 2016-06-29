" GOLANG (See: https://github.com/fatih/vim-go)
" =============================================
let g:go_highlight_functions = 1         " ⎤
let g:go_highlight_methods = 1           " ⎟ Better highlighting.
let g:go_highlight_structs = 1           " ⎟
let g:go_highlight_operators = 1         " ⎟
let g:go_highlight_build_constraints = 1 " ⎦
let g:go_fmt_command = "goimports"

let g:go_autodetect_gopath = 0

" Syntastic.
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['go'] }

" go get -u github.com/jstemmer/gotags
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }

