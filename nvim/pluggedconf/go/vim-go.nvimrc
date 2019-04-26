" Highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_type_info = 1
let g:go_gocode_propose_source=0

let g:go_metalinter_enabled = [ "gosec", "goconst", "gocyclo", "golint", "ineffassign", "interfacer", "maligned", "megacheck", "misspell", "structcheck", "unconvert", "varcheck", "vet"]
let g:go_def_mode = 'godef'

let g:go_addtags_transform = "snakecase"
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1

if !exists("g:go_gotags_bin")
  let g:go_gotags_bin = "gotags"
endif

" highlight matching identifiers
let g:go_auto_sameids = 1

" vim-go mappings
autocmd FileType go nmap <buffer><leader>d :GoDeclsDir<cr>

autocmd FileType go nmap <buffer><leader>gr <plug>(go-run)
autocmd FileType go nmap <buffer><leader>gt <plug>(go-test)
autocmd FileType go nmap <buffer><leader>gb <plug>(go-build)
autocmd FileType go nmap <buffer><leader>gi <plug>(go-install)

autocmd FileType go nmap <buffer><leader>gtf <plug>(go-test-func)
autocmd FileType go nmap <buffer><leader>gtc <plug>(go-coverage-toggle)

autocmd FileType go nmap <buffer><leader>grn <plug>(go-rename)

autocmd FileType go nmap <buffer><leader>gat :GoAddTags<space>
autocmd FileType go nmap <buffer><leader>gdt :GoRemoveTags<CR>

autocmd Filetype go nmap <buffer><leader>tu <Plug>(go-alternate-edit)
autocmd Filetype go nmap <buffer><leader>tub <Plug>(go-alternate-split)
autocmd Filetype go nmap <buffer><leader>tuv <Plug>(go-alternate-vertical)

" autocmd FileType go nmap <buffer><leader>gim <plug>(go-implements)
autocmd FileType go nmap <buffer><leader>gc <plug>(go-callee)

" autocmd FileType go nmap <buffer><leader>gd :exec "GoDoc ".expand("<c-r><c-f>")<cr>
autocmd FileType go nmap <buffer><leader>u :exec "GoImport ".expand("<cword>")<cr>

autocmd FileType go nmap <buffer><leader>gfs :exec "GoFillStruct"<cr>

" Require vim-go
inoremap <silent><buffer> . <esc>:call AliasGoImport()<cr>

function! AliasGoImport()
    let l:skip = !has_key(v:completed_item, 'word') || v:completed_item['kind'] !=# 'M'

    if !l:skip
        let l:currentPackage = v:completed_item['word']
        let l:importPath = substitute(substitute(v:completed_item['menu'], ' \[LS\]', '', ''), '"', '', 'g')
    endif

    if !l:skip
        " check if selected package is already imported
        let [s:line, s:col] = searchpos('"'.l:importPath.'"', 'n')
        let l:skip = s:line
    endif

    if !l:skip
        " check if different package with same name is already imported
        let [s:line, s:col] = searchpos('\s\+".\+/'.l:currentPackage.'"$', 'n')
        if s:line > 0
            let l:alias = input('Package already imported. Alias '.l:importPath.' as: ')
            if l:alias ==# ''
                echo 'No alias given - not doing anything'
            else
                let l:cmd = 'GoImportAs ' . l:alias . ' ' . l:importPath
                execute l:cmd
                execute 'normal! ciw'.l:alias
            endif

            let l:skip = 1
        endif
    endif

    if !l:skip
        let l:cmd = 'GoImport ' . l:importPath
        execute l:cmd
    endif

    normal! a.
    if col('.') == col('$') - 1
        startinsert!
    else
        normal! l
        startinsert
    end
endfunction
