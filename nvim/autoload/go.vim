function! go#Settagbar()
    let bin_path = go#path#CheckBinPath(g:go_gotags_bin)
    if empty(bin_path)
        return
    endif

    if !exists("g:tagbar_type_go")
        let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : bin_path,
        \ 'ctagsargs' : '-sort -silent'
        \ }
    endif
endfunction


function! go#AliasGoImport()
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
