augroup lua
  autocmd!
augroup END

command! -buffer -bang Love compiler love | silent Make!
" command! -buffer -bang Love compiler love | silent make! | cwindow
