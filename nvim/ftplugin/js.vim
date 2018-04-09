" Declare the general config group for autocommand
augroup js
    autocmd!
augroup END

" write ctags each time we save files (& for asynchronously)
autocmd js BufWritePost *.js silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
