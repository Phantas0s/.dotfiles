" source every plugin configs
for file in split(glob($XDG_CONFIG_HOME . '/nvim/pluggedconf/php/*.nvimrc'), '\n')
    exe 'source' file
endfor

" write ctags each time we save files (& for asynchronously)
" autocmd php BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

" php docs
let g:pdv_template_dir = $XDG_CONFIG_HOME .'/nvim/plugged/pdv/templates'
noremap <buffer><leader>d :call pdv#DocumentCurrentLine()<CR>

" FormatPHPLineLength - can split array or list of arguments on multiple lines.
nnoremap <buffer><leader>G :call php#FormatPHPLineLength()<cr>
