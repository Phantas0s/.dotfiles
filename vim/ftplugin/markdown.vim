" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/md/*.nvimrc"), '\n')
    exe 'source' file
endfor
