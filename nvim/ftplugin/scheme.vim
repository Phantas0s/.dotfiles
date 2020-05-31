set nospell

for file in split(glob($XDG_CONFIG_HOME . "/nvim/pluggedconf/lisp/*.nvimrc"), '\n')
    exe 'source' file
endfor
