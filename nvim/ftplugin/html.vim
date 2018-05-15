" reformat with external tools
nnoremap <leader>c :%s/<[^>]*>/\r&\r/g<cr>gg=G:g/^$/d<cr><leader>/
nnoremap <silent><leader>x :!xdg-open %<cr>
