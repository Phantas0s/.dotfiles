augroup csv
    au!
augroup END

let g:no_csv_maps = 1
let g:csv_autocmd_arrange = 1

" align all columns to the left
let g:csv_arrange_align  = 'l*'
autocmd csv BufRead,BufWritePost *.csv :%ArrangeColumn!
autocmd csv BufWritePre *.csv :%UnArrangeColumn

:let g:csv_default_delim=','
