augroup json 
    autocmd!
augroup END

autocmd json FileType json setlocal ts=2 sts=2 sw=2 expandtab

" reformat with external tools
autocmd json FileType json nnoremap <leader>c :%!python -m json.tool<cr>
