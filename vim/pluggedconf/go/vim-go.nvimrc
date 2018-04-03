let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:go_auto_sameids = 1

" vim-go mappings
autocmd vimrc FileType go nmap <buffer> <leader>gr <plug>(go-run)
autocmd vimrc FileType go nmap <buffer> <leader>gb <plug>(go-build)
autocmd vimrc FileType go nmap <buffer> <leader>gt <plug>(go-test)
autocmd vimrc FileType go nmap <buffer> <leader>grr <plug>(go-rename)
autocmd vimrc FileType go nmap <buffer> <leader>] <plug>(go-def-vertical)
autocmd vimrc FileType go nmap <buffer> <C-]> <plug>(go-def-vertical)
autocmd vimrc FileType go nmap <buffer> <leader>gi <plug>(go-info)
