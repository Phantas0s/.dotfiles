" Declare the general config group for autocommand
augroup go 
    autocmd!
augroup END

" use real tabs in .go files, not spaces
autocmd go FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/go/*.nvimrc"), '\n')
    exe 'source' file
endfor
