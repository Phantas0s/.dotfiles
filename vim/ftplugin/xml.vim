" reformat with external tools
autocmd vimrc FileType xml nnoremap <leader>c :%!xmllint --format - <cr>
