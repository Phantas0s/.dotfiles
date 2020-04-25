augroup vim
  autocmd!
augroup END

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/vim/*.nvimrc"), '\n')
    exe 'source' file
endfor

set foldmethod=marker
set foldlevelstart=0

