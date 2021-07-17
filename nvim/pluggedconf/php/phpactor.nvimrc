augroup php
  autocmd!
augroup END

let g:phpactorOmniError = v:true
autocmd php FileType php setlocal omnifunc=phpactor#Complete

" namespace automatic insert
nnoremap <buffer><leader>u :call phpactor#UseAdd()<cr>

nnoremap <buffer><leader>rmc :call phpactor#MoveFile()<cr>
nnoremap <buffer><leader>rcc :call phpactor#CopyFile()<cr>

nnoremap <buffer><leader>fr :call phpactor#FindReferences()<cr>
nnoremap <buffer><leader>ip :PhpactorGotoImplementations<CR>
nnoremap <buffer><leader>] :PhpactorGotoDefinition<CR>

nnoremap <buffer><leader>ic :call PHPModify("implement_contracts")<cr>
nnoremap <buffer><leader>ap :call PHPModify("add_missing_properties")<cr>

" Fill constructor
nnoremap <buffer><leader>fc :call PHPModify("complete_constructor")<cr>

" Extract interface
nnoremap <buffer><leader>rei :call phpactor#ClassInflect()<cr>

" Extract method
xnoremap <buffer><silent><leader>rem :<C-U>call phpactor#ExtractMethod()<CR>
nnoremap <buffer><leader>src :call phpactor#FindReferences()<cr>


function! PHPModify(transformer)
    normal! ggdG
    execute "read !phpactor class:transform ".expand('%').' --transform='.a:transformer
    normal! ggdd
endfunction
