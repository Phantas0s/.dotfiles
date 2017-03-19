let g:vim_php_refactoring_use_default_mapping = 0

autocmd FileType php nnoremap <leader>rlv :call PhpRenameLocalVariable()<CR>
autocmd FileType php nnoremap <leader>rcv :call PhpRenameClassVariable()<CR>
autocmd FileType php nnoremap <leader>rrm :call PhpRenameMethod()<CR>
autocmd FileType php nnoremap <leader>reu :call PhpExtractUse()<CR>
autocmd FileType php vnoremap <leader>rec :call PhpExtractConst()<CR>
autocmd FileType php nnoremap <leader>rep :call PhpExtractClassProperty()<CR>
autocmd FileType php vnoremap <leader>rem :call PhpExtractMethod()<CR>
autocmd FileType php nnoremap <leader>rcp :call PhpCreateProperty()<CR>
autocmd FileType php nnoremap <leader>rdu :call PhpDetectUnusedUseStatements()<CR>
autocmd FileType php vnoremap <leader>raa :call PhpAlignAssigns()<CR>
autocmd FileType php nnoremap <leader>rsg :call PhpCreateSettersAndGetters()<CR>
