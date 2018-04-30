" Highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_metalinter_enabled = [ "gas", "goconst", "gocyclo", "golint", "ineffassign", "interfacer", "maligned", "megacheck", "misspell", "structcheck", "unconvert", "varcheck", "vet"]
" temporary fix for neovim + guru + vim-go problem - https://github.com/fatih/vim-go/pull/1769
" let g:go_def_mode = 'godef'

" highlight matching identifiers
let g:go_auto_sameids = 1

" vimdoctor 
xnoremap <buffer><leader>rem :Refactor extract 
noremap <buffer><leader>rd :Refactor godoc<cr>

" vim-go mappings
autocmd FileType go nmap <buffer><leader>d :GoDeclsDir<cr>

autocmd FileType go nmap <buffer><leader>r <plug>(go-run)
autocmd FileType go nmap <buffer><leader>t <plug>(go-test)
autocmd FileType go nmap <buffer><leader>i <plug>(go-install)
autocmd FileType go nmap <buffer><leader>c <plug>(go-coverage-toggle)
autocmd FileType go nmap <buffer><leader>gb <plug>(go-build)
autocmd FileType go nmap <buffer><leader>gtf <plug>(go-test-func)

autocmd FileType go nmap <buffer><leader>gr <plug>(go-rename)

autocmd FileType go nmap <buffer><leader>gd :exec "GoDoc ".expand("<c-r><c-f>")<cr>
autocmd FileType go nmap <buffer><leader>u :exec "GoImport ".expand("<cword>")<cr>

let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
