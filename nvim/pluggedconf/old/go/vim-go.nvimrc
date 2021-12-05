" Highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_type_info = 0
let g:go_gocode_propose_source=0

let g:go_metalinter_enabled = [ "gosec", "goconst", "gocyclo", "golint", "ineffassign", "interfacer", "maligned", "megacheck", "misspell", "structcheck", "unconvert", "varcheck", "vet"]
let g:go_def_mode = 'godef'

let g:go_addtags_transform = "snakecase"
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1

let g:go_doc_popup_window = 1

if !exists("g:go_gotags_bin")
  let g:go_gotags_bin = "gotags"
endif

" highlight matching identifiers
let g:go_auto_sameids = 1

" vim-go mappings
autocmd FileType go nmap <buffer><localleader>d :GoDeclsDir<cr>

autocmd FileType go nmap <buffer><localleader>gr <plug>(go-run)
autocmd FileType go nmap <buffer><localleader>gt <plug>(go-test)
autocmd FileType go nmap <buffer><localleader>gb <plug>(go-build)
autocmd FileType go nmap <buffer><localleader>gi <plug>(go-install)

autocmd FileType go nmap <buffer><localleader>gtf <plug>(go-test-func)
autocmd FileType go nmap <buffer><localleader>gtc <plug>(go-coverage-toggle)

autocmd FileType go nmap <buffer><localleader>grn <plug>(go-rename)

autocmd FileType go nmap <buffer><localleader>gat :GoAddTags<space>
autocmd FileType go nmap <buffer><localleader>gdt :GoRemoveTags<CR>

autocmd FileType go nmap <buffer><localleader>tu <Plug>(go-alternate-edit)
autocmd FileType go nmap <buffer><localleader>tuh <Plug>(go-alternate-split)
autocmd FileType go nmap <buffer><localleader>tuv <Plug>(go-alternate-vertical)

autocmd FileType go nmap <buffer><localleader>gim <plug>(go-implements)
autocmd FileType go nmap <buffer><localleader>gc <plug>(go-callee)

" autocmd FileType go nmap <buffer><localleader>gd :exec "GoDoc ".expand("<c-r><c-f>")<cr>
autocmd FileType go nmap <buffer><localleader>u :exec "GoImport ".expand("<cword>")<cr>

autocmd FileType go nmap <buffer><localleader>gfs :exec "GoFillStruct"<cr>

" Require vim-go
" inoremap <silent><buffer> . <esc>:call go#AliasGoImport()<cr>
let g:go_gopls_enabled=0
