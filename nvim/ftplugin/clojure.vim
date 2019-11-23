" Declare the general config group for autocommand
augroup clojure
    autocmd!
augroup END

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/clojure/*.nvimrc"), '\n')
    exe 'source' file
endfor
