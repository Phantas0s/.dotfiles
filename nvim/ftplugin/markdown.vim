" source every plugin configs
for file in split(glob($XDG_CONFIG_HOME . "/nvim/pluggedconf/markdown/*.nvimrc"), '\n')
    exe 'source' file
endfor

" " cancel the number toggled defined in init file
" augroup mdnumbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * setlocal norelativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * setlocal norelativenumber
" augroup END

" Write mode
" setlocal number norelativenumber
setlocal spell
setlocal spelllang=en_us

" let g:markdown_folding=1
" norm! zi

" function s:ACodeBlock(inside) abort
"     " Search forward for the end of the block; move the cursor.
"     " 'c' accepts a match at the cursor position, in case we're on a delimiter.
"     " 'W' doesn't wrap around the end of the file, not deleting the first block if there is no next block in the buffer.
"     let endBlock = search('\v^```$', 'cW')
"     if endBlock != 0
"         " Search for the start of the block.
"         " 'b' search backward.
"         " 'n' doesn't move the cursor.
"         " 'c' accepts a match at the cursor position, in case we're on a delimiter.
"         let startBlock = search('\v```[a-z]*$', 'bnc')

"         execute startBlock
"         if a:inside
"             normal! j
"         endif
"         normal! V
"         execute endBlock
"         if a:inside
"             normal! k
"         endif
"     endif
" endfunc

" onoremap <buffer> ac :<c-u>call <sid>ACodeBlock(v:false)<cr>
" onoremap <buffer> ic :<c-u>call <sid>ACodeBlock(v:true)<cr>
" xnoremap <buffer> ac :<c-u>call <sid>ACodeBlock(v:false)<cr>
" xnoremap <buffer> ic :<c-u>call <sid>ACodeBlock(v:true)<cr>
