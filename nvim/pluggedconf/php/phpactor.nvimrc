" This use a global install of PHPActor and not the Vim plugin for even more
" configuration possibilities

" namespace automatic insert
nnoremap <leader>u :call phpactor#UseAdd()<cr>

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
xnoremap <silent><Leader>rem :<C-U>call phpactor#ExtractMethod()<CR>
nnoremap <leader>src :call phpactor#FindReferences()<cr>

" go to definition of a method / class / whatever via Ctags
" map <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <leader>] :call phpactor#GotoDefinition()<CR>

function! PHPModify(transformer)
    normal! ggdG
    execute "read !phpactor class:transform ".expand('%').' --transform='.a:transformer
    normal! ggdd
endfunction
