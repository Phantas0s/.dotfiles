augroup xml
  autocmd!
augroup END

autocmd xml BufNewFile,BufRead *.tmTheme set filetype=xml

" reformat with external tools
autocmd xml nnoremap <buffer><leader>g :%!xmllint --format - <cr>
