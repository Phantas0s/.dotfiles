" This use a global install of PHPActor and not the Vim plugin for even more
" configuration possibilities

nnoremap <leader>rmc :call phpactor#MoveFile()<cr>
nnoremap <leader>rcc :call phpactor#CopyFile()<cr>

nnoremap <leader>rmd :call phpactor#FindReferences()<cr>

nnoremap <leader>ric :call PHPModify("implement_contracts")<cr>
nnoremap <leader>rap :call PHPModify("add_missing_properties")<cr>

" Fill constructor
nnoremap <leader>rfc :call PHPModify("complete_constructor")<cr>

" Extract interface
nnoremap <leader>rei :call phpactor#ClassInflect()<cr>

" Extract method
nnoremap <leader>rem :call phpactor#ExtractMethod()<cr>
nnoremap <leader>src :call phpactor#FindReferences()()<cr>

function! PHPModify(transformer)
    normal! ggdG
    execute "read !phpactor class:transform ".expand('%').' --transform='.a:transformer
    normal! ggdd
endfunction
