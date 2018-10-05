let g:vim_markdown_preview_github=1
let g:vim_markdown_preview_toggle=1
let g:vim_markdown_preview_browser='Google Chrome'

if has('unix')
  let g:vim_markdown_preview_use_xdg_open=1
endif

noremap <leader>m :call Vim_Markdown_Preview_Local()<CR>
setlocal conceallevel=0
setlocal formatoptions-=tc
setlocal textwidth=0
setlocal wrapmargin=0
