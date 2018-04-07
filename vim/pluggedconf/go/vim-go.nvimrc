" Highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" temporary fix for neovim + guru + vim-go problem - https://github.com/fatih/vim-go/pull/1769
let g:go_def_mode = 'godef'

" highlight matching identifiers
let g:go_auto_sameids = 1

" vimdoctor 
vnoremap <buffer> <leader>rem :Refactor extract 
noremap <buffer> <leader>rd :Refactor godoc<cr>

" vim-go mappings
autocmd vimrc FileType go nmap <buffer> <leader>gr <plug>(go-run)
autocmd vimrc FileType go nmap <buffer> <leader>gb <plug>(go-build)
autocmd vimrc FileType go nmap <buffer> <leader>gt <plug>(go-test)
autocmd vimrc FileType go nmap <buffer> <leader>grn <plug>(go-rename)

autocmd vimrc FileType go nmap <buffer><leader>gd :exec "GoDoc ".expand("<cWORD>")<cr>
autocmd vimrc FileType go nmap <buffer><leader>u :exec "GoImport ".expand("<cword>")<cr>
