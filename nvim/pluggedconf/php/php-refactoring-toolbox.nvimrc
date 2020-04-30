let g:vim_php_refactoring_use_default_mapping = 0

let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

autocmd vimrc FileType php nnoremap <buffer><leader>reu :call PhpExtractUse()<CR>
autocmd vimrc FileType php xnoremap <buffer><leader>rec :call PhpExtractConst()<CR>
autocmd vimrc FileType php nnoremap <buffer><leader>rep :call PhpExtractClassProperty()<CR>

autocmd vimrc FileType php nnoremap <buffer><leader>rrm :call PhpRenameMethod()<CR>

autocmd vimrc FileType php nnoremap <buffer><leader>rcp :call PhpCreateProperty()<CR>
autocmd vimrc FileType php nnoremap <buffer><leader>rrp :call PhpRenameClassVariable()<CR>

autocmd vimrc FileType php nnoremap <buffer><leader>rlv :call PhpRenameLocalVariable()<CR>
autocmd vimrc FileType php nnoremap <buffer><leader>rdu :call PhpDetectUnusedUseStatements()<CR>
autocmd vimrc FileType php xnoremap <buffer><leader>raa :call PhpAlignAssigns()<CR>
autocmd vimrc FileType php nnoremap <buffer><leader>rsg :call PhpCreateSettersAndGetters()<CR>

xnoremap <buffer><leader>rev :call PHPExtractVariable()<cr>

function! PHPExtractVariable()
    let l:name = input("Name of new variable: $")
    normal! gvx
    execute "normal! i$".l:name
    execute "normal! O$".l:name." = "
    normal! pa;
endfunction

