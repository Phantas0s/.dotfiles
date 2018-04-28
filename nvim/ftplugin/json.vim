augroup json 
    autocmd!
augroup END

" reformat with external tools
autocmd vimrc FileType json nnoremap <leader>c :%!python -m json.tool<cr>

