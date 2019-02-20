augroup xml
  autocmd!
augroup END

" reformat with external tools
autocmd xml FileType xml nnoremap <leader>c :%!xmllint --format - <cr>
autocmd xml BufNewFile,BufRead *.tmTheme set filetype=xml
