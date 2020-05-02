augroup vim
  autocmd!
augroup END

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/vim/*.nvimrc"), '\n')
    exe 'source' file
endfor

" Eval selection
vnoremap <buffer><leader>E "xy:@x<CR>
" Eval current line
nnoremap <buffer><leader>X "xy$:@x<CR>
