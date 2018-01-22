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
nnoremap <leader>rem :call phpactor#mxtractMethod()<cr>
nnoremap <leader>src :call PHPShowReferencesClass()<cr>

function! PHPShowReferencesClass()
    execute "!phpactor references:class ".expand('%')
endfunction

function! PHPMoveDir()
    let l:oldPath = input("old path: ", expand('%:p:h'))
    let l:newPath = input("New path: ", l:oldPath)
    execute "!phpactor class:move ".l:oldPath.' '.l:newPath
endfunction

function! PHPModify(transformer)
    normal! ggdG
    execute "read !phpactor class:transform ".expand('%').' --transform='.a:transformer
    normal! ggdd
endfunction

function! PHPExtractInterface()
    let l:interfaceFile = substitute(expand('%'), '.php', 'Interface.php', '')
    execute "!phpactor class:inflect ".expand('%').' '.l:interfaceFile.' interface'
    execute "e ". l:interfaceFile
endfunction
