" TODO to test all of that

function! Expand(exp) abort
    let l:result = expand(a:exp)
    return l:result ==# '' ? '' : "file://" . l:result
endfunction

nnoremap <buffer><silent><leader> crcc :call LanguageClient#workspace_executeCommand('cycle-coll', [Expand('%:p'), line('.') - 1, col('.') - 1])<CR>
nnoremap <buffer><silent><leader> crth :call LanguageClient#workspace_executeCommand('thread-first', [Expand('%:p'), line('.') - 1, col('.') - 1])<CR>
nnoremap <buffer><silent><leader> crtt :call LanguageClient#workspace_executeCommand('thread-last', [Expand('%:p'), line('.') - 1, col('.') - 1])<CR>
nnoremap <buffer><silent><leader> crtf :call LanguageClient#workspace_executeCommand('thread-first-all', [Expand('%:p'), line('.') - 1, col('.') - 1])<CR>
nnoremap <buffer><silent><leader> crtl :call LanguageClient#workspace_executeCommand('thread-last-all', [Expand('%:p'), line('.') - 1, col('.') - 1])<CR>
nnoremap <buffer><silent><leader> crml :call LanguageClient#workspace_executeCommand('move-to-let', [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')])<CR>
nnoremap <buffer><silent><leader> cril :call LanguageClient#workspace_executeCommand('introduce-let', [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')])<CR>
nnoremap <buffer><silent><leader> crel :call LanguageClient#workspace_executeCommand('expand-let', [Expand('%:p'), line('.') - 1, col('.') - 1])<CR>
nnoremap <buffer><silent><leader> cram :call LanguageClient#workspace_executeCommand('add-missing-libspec', [Expand('%:p'), line('.') - 1, col('.') - 1])<CR>

