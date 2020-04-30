" reformat with external tools
nnoremap <buffer><leader>c :%s/<[^>]*>/\r&\r/g<cr>gg=G:g/^$/d<cr><leader>/
nnoremap <buffer><silent><leader>x :!xdg-open %<cr>
