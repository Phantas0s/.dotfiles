" update neomake when save file
autocmd! BufWritePost * Neomake

" enable markers - verification in order of the arguments
let g:neomake_php_enabled_makers = ['php', 'phpcs']
" standard phpcs config
let g:neomake_php_phpcs_args_standard = 'PSR2'
