augroup csv 
    autocmd!
augroup END

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/csv/*.nvimrc"), '\n')
    exe 'source' file
endfor
