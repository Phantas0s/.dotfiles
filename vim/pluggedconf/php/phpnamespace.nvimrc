let g:php_namespace_sort_after_insert = 1

" insert use statement in PHP
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction

autocmd vimrc FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd vimrc FileType php noremap <Leader>u :call PhpInsertUse()<CR>
