" write ctags each time we save files (& for asynchronously)
autocmd vimrc BufWritePost *.js silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
