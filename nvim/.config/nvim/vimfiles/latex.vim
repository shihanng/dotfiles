let g:tex_flavor = "latex"
let g:vimtex_fold_enabled = 1

if has('macunix')
  let g:vimtex_view_general_options = '-r @line @pdf @tex'
  let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options_latexmk = '-r 1'
else
  let g:vimtex_view_general_viewer = 'okular'
  let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
  let g:vimtex_view_general_options_latexmk = '--unique'
endif


