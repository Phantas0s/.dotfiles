let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_rules = "@PSR2"

autocmd FileType php setlocal commentstring=\/\/\ %s
autocmd FileType php nnoremap <leader>g :silent :call PhpCsFixerFixFile()<CR>
