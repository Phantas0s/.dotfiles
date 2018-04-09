" Declare the general config group for autocommand
augroup go 
    autocmd!
augroup END

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/go/*.nvimrc"), '\n')
    exe 'source' file
endfor
