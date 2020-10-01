" source every plugin configs
for file in split(glob($XDG_CONFIG_HOME . "/nvim/pluggedconf/agda/*.nvimrc"), '\n')
    exe 'source' file
endfor
