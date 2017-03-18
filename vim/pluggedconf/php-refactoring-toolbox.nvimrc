let g:vim_php_refactoring_use_default_mapping = 0

nnoremap <leader>rlv :call PhpRenameLocalVariable()<CR>
nnoremap <leader>rcv :call PhpRenameClassVariable()<CR>
nnoremap <leader>rrm :call PhpRenameMethod()<CR>
nnoremap <leader>reu :call PhpExtractUse()<CR>
vnoremap <leader>rec :call PhpExtractConst()<CR>
nnoremap <leader>rep :call PhpExtractClassProperty()<CR>
vnoremap <leader>rem :call PhpExtractMethod()<CR>
nnoremap <leader>rnp :call PhpCreateProperty()<CR>
nnoremap <leader>rdu :call PhpDetectUnusedUseStatements()<CR>
vnoremap <leader>r== :call PhpAlignAssigns()<CR>
nnoremap <leader>rsg :call PhpCreateSettersAndGetters()<CR>




