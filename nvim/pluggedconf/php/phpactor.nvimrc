augroup php
  autocmd!
augroup END

let g:phpactorOmniError = v:true
autocmd php FileType php setlocal omnifunc=phpactor#Complete

" namespace automatic insert
nnoremap <buffer><localleader>u :call phpactor#UseAdd()<cr>

nnoremap <buffer><localleader>rmf :call phpactor#MoveFile()<cr>
nnoremap <buffer><localleader>rcf :call phpactor#CopyFile()<cr>

nnoremap <buffer><localleader>rfr :call phpactor#FindReferences()<cr>
nnoremap <buffer><localleader>rii :PhpactorGotoImplementations<CR>
nnoremap <buffer><localleader>] :PhpactorGotoDefinition<CR>

nnoremap <buffer><localleader>ric :call PHPModify("implement_contracts")<cr>
nnoremap <buffer><localleader>rap :call PHPModify("add_missing_properties")<cr>

nnoremap <buffer><localleader>ruc :PhpactorImportClass<cr>
nnoremap <buffer><localleader>rca :PhpactorGenerateAccessor<cr>

" Fill constructor
nnoremap <buffer><silent><localleader>rcc :call PHPModify("complete_constructor")<cr>

" Extract interface
nnoremap <buffer><localleader>rei :call phpactor#ClassInflect()<cr>

" Extract method
xnoremap <buffer><silent><localleader>rem :<C-U>call phpactor#ExtractMethod()<CR>
"
" autocmd php BufWritePost *.php silent! PhpactorImportMissingClasses

function! PHPModify(transformer)
    normal! ggdG
    execute "read !phpactor class:transform ".expand('%').' --transform='.a:transformer
    normal! ggdd
endfunction
