" ==================================== Emmet ===================================
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript.jsx EmmetInstall
let g:user_emmet_settings = {
\  'javascript' : {
\    'extends' : 'jsx',
\  },
\}
