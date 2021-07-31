augroup php
  autocmd!
augroup END

let g:phpactorOmniError = v:true
autocmd php FileType php setlocal omnifunc=phpactor#Complete

" namespace automatic insert
nnoremap <buffer><leader>u :call phpactor#UseAdd()<cr>

nnoremap <buffer><leader>rmf :call phpactor#MoveFile()<cr>
nnoremap <buffer><leader>rcf :call phpactor#CopyFile()<cr>

nnoremap <buffer><leader>rfr :call phpactor#FindReferences()<cr>
nnoremap <buffer><leader>rii :PhpactorGotoImplementations<CR>
nnoremap <buffer><leader>] :PhpactorGotoDefinition<CR>

nnoremap <buffer><leader>ric :call PHPModify("implement_contracts")<cr>
nnoremap <buffer><leader>rap :call PHPModify("add_missing_properties")<cr>

nnoremap <buffer><leader>ruc :PhpactorImportClass<cr>
nnoremap <buffer><leader>rca :PhpactorGenerateAccessor<cr>

" Fill constructor
nnoremap <buffer><leader>rcc :call PHPModify("complete_constructor")<cr>

" Extract interface
nnoremap <buffer><leader>rei :call phpactor#ClassInflect()<cr>

" Extract method
xnoremap <buffer><silent><leader>rem :<C-U>call phpactor#ExtractMethod()<CR>
"
autocmd php BufWritePost *.php silent! PhpactorImportMissingClasses

function! PHPModify(transformer)
    normal! ggdG
    execute "read !phpactor class:transform ".expand('%').' --transform='.a:transformer
    normal! ggdd
endfunction
