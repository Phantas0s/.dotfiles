setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Declare the general config group for autocommand
augroup js
    autocmd!
augroup END

command! -buffer -bang Pretty silent %!prettier --stdin-filepath %

" source every plugin configs
for file in split(glob($XDG_CONFIG_HOME . "/nvim/pluggedconf/js/*.nvimrc"), '\n')
    exe 'source' file
endfor
