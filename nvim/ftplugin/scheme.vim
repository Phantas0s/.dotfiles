set nospell

for file in split(glob("~/nvim/pluggedconf/lisp/*.nvimrc"), '\n')
    exe 'source' file
endfor
