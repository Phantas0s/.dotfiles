augroup xml
  autocmd!
augroup END

autocmd xml BufNewFile,BufRead *.tmTheme, *.mm set filetype=xml

" reformat with external tools
autocmd xml nmap <buffer><leader>g :%!xmllint --format - <cr>
