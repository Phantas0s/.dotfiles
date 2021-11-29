let g:vim_php_refactoring_use_default_mapping = 0

let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

autocmd vimrc FileType php nnoremap <buffer><localleader>reu :call PhpExtractUse()<CR>
autocmd vimrc FileType php xnoremap <buffer><localleader>rec :call PhpExtractConst()<CR>
autocmd vimrc FileType php nnoremap <buffer><localleader>rep :call PhpExtractClassProperty()<CR>

autocmd vimrc FileType php nnoremap <buffer><localleader>rrm :call PhpRenameMethod()<CR>

autocmd vimrc FileType php nnoremap <buffer><localleader>rcp :call PhpCreateProperty()<CR>
autocmd vimrc FileType php nnoremap <buffer><localleader>rrp :call PhpRenameClassVariable()<CR>

autocmd vimrc FileType php nnoremap <buffer><localleader>rlv :call PhpRenameLocalVariable()<CR>
autocmd vimrc FileType php nnoremap <buffer><localleader>rdu :call PhpDetectUnusedUseStatements()<CR>
autocmd vimrc FileType php xnoremap <buffer><localleader>raa :call PhpAlignAssigns()<CR>
autocmd vimrc FileType php nnoremap <buffer><localleader>rsg :call PhpCreateSettersAndGetters()<CR>

xnoremap <buffer><localleader>rev :call PHPExtractVariable()<cr>

function! PHPExtractVariable()
    let l:name = input("Name of new variable: $")
    normal! gvx
    execute "normal! i$".l:name
    execute "normal! O$".l:name." = "
    normal! pa;
endfunction

