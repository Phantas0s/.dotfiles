let g:no_csv_maps = 1
" let g:csv_autocmd_arrange = 1

autocmd csv BufRead,BufWritePost *.csv :%ArrangeColumn!
autocmd csv BufWritePre *.csv :%UnArrangeColumn

