nnoremap <leader>rmc :call PHPMoveClass()<cr>
nnoremap <leader>rmd :call PHPMoveDir()<cr>
nnoremap <leader>ric :call PHPModify("implement_contracts")<cr>
nnoremap <leader>raa :call PHPModify("add_missing_assignments")<cr>
nnoremap <leader>rcc :call PHPModify("complete_constructor")<cr>
nnoremap <leader>rei :call PHPExtractInterface()<cr>

function! PHPMoveClass()
    :w
    let l:oldPath = expand('%')
    let l:newPath = input("New path: ", l:oldPath)
    execute "!phpactor class:move ".l:oldPath.' '.l:newPath
    execute "bd ".l:oldPath
    execute "e ". l:newPath
endfunction

function! PHPMoveDir()
    :w
    let l:oldPath = input("old path: ", expand('%:p:h'))
    let l:newPath = input("New path: ", l:oldPath)
    execute "!phpactor class:move ".l:oldPath.' '.l:newPath
endfunction

function! PHPModify(transformer)
    :w
    normal! ggdG
    execute "read !phpactor class:transform ".expand('%').' --transform='.a:transformer
    normal! ggdd
    :w
endfunction

function! PHPExtractInterface()
    :w
    let l:interfaceFile = substitute(expand('%'), '.php', 'Interface.php', '')
    execute "!phpactor class:inflect ".expand('%').' '.l:interfaceFile.' interface'
    execute "e ". l:interfaceFile
endfunction
