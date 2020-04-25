augroup xml
  autocmd!
augroup END

" reformat with external tools
autocmd xml nnoremap <leader>g :%!xmllint --format - <cr>
autocmd xml BufNewFile,BufRead *.tmTheme set filetype=xml
