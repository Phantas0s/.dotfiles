" Declare the general config group for autocommand
augroup php
  autocmd!
augroup END

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/php/*.nvimrc"), '\n')
    exe 'source' file
endfor

" write ctags each time we save files (& for asynchronously)
autocmd php BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

" php docs
let g:pdv_template_dir = $HOME ."/nvim/plugged/pdv/templates_snip"
noremap <leader>d :call pdv#DocumentWithSnip()<CR>

" FormatPHPLineLength - can split array or list of arguments on multiple lines.
nnoremap <leader>G :call php#FormatPHPLineLength()<cr>
