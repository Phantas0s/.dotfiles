setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

command! -buffer -bang Pretty silent %!prettier --stdin-filepath %

" source every plugin configs
for file in split(glob($XDG_CONFIG_HOME . "/nvim/pluggedconf/js/*.nvimrc"), '\n')
    exe 'source' file
endfor
