let g:vim_php_refactoring_use_default_mapping = 0

let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

autocmd FileType php nnoremap <leader>reu :call PhpExtractUse()<CR>
autocmd FileType php vnoremap <leader>rec :call PhpExtractConst()<CR>
autocmd FileType php nnoremap <leader>rep :call PhpExtractClassProperty()<CR>

autocmd FileType php nnoremap <leader>rrm :call PhpRenameMethod()<CR>

autocmd FileType php nnoremap <leader>rcp :call PhpCreateProperty()<CR>
autocmd FileType php nnoremap <leader>rrp :call PhpRenameClassVariable()<CR>

autocmd FileType php nnoremap <leader>rlv :call PhpRenameLocalVariable()<CR>
autocmd FileType php nnoremap <leader>rdu :call PhpDetectUnusedUseStatements()<CR>
autocmd FileType php vnoremap <leader>raa :call PhpAlignAssigns()<CR>
autocmd FileType php nnoremap <leader>rsg :call PhpCreateSettersAndGetters()<CR>

vnoremap <leader>rev :call PHPExtractVariable()<cr>

function! PHPExtractVariable()
    let l:name = input("Name of new variable: $")
    normal! gvx
    execute "normal! i$".l:name
    execute "normal! O$".l:name." = "
    normal! pa;
endfunction

