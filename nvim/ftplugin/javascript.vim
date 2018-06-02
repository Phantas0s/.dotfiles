" Declare the general config group for autocommand
augroup js
    autocmd!
augroup END

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/js/*.nvimrc"), '\n')
    exe 'source' file
endfor

" write ctags each time we save files (& for asynchronously)
autocmd js BufWritePost *.js silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
