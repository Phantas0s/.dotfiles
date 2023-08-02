" source every plugin configs
for file in split(glob($XDG_CONFIG_HOME . "/nvim/pluggedconf/md/*.nvimrc"), '\n')
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
