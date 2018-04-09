" FormatPHPLineLength - can split array or list of arguments on multiple lines.
function! php#FormatPHPLineLength()
    let l:currentLine = getline('.')
    normal! ma

    let l:isConditional = l:currentLine =~ '\s*&&' || l:currentLine =~ ' and ' || l:currentLine =~ '\s*||' || l:currentLine =~ ' or ' || l:currentLine =~ '\s*?.*:'
    if l:isConditional
        :s/\(\s*&&\| and \|\s*||\| or \| ?\| :\)/\r\1/g
        if getline('.') =~ ') {'
            exe "normal! $hhi\n"
        endif
        normal! =ip
    endif

    " split params
    let l:isFunctionCall = len(split(l:currentLine, '(.\+)', 1)) - 1
    if l:isFunctionCall > 0
        try
            s#\((\)\([^)]\+\)\().*\)#\1\r\2\r\3#
            normal! k
            if getline('.') =~ ',\s'
                s/,\s/,\r/g
            endif
            normal! j
            if getline('.') =~ '))'
                exe "normal! kJa\n"
            endif
            normal! =a(
        catch
        endtry
    endif

    " format array
    let l:isArray = len(split(l:currentLine, '.\+\zs\[.\+\]', 1)) - 1
    if l:isArray > 0
        try
            s/\(\[\)\(.\+\)\(]\)/\1\r\2\r\3

            normal! k

            if l:currentLine =~ ',\s'
                s/,\s/,\r/g
            endif

            if getline('.') !~ ',$'
                normal! A,
            endif

            normal! =a[
        catch
        endtry
    endif

    " " multiple object operator split - repeatable
    let l:numOfObjectOperators = len(split(l:currentLine, '->', 1)) - 1
    if l:numOfObjectOperators > 1
        try
            s/.*->.*\zs->/\r->/g
            normal! ='a
        catch
        endtry
    endif
endfunction

" Create automatically test files / can switch between tests and tested files
" Super powerful for TDD!!

" firstDirBeginning: test path / secondDirBeginning: source path
" a fifth argument can be added if tests is in a subdirectory
" a sixth argument can be added to use a special command to open the file (like vsp)

" example:
" Test filepath: src/Tests/Model/ModelTest.php
" File tested filepath: src/Model/Model.php
" Result: autocmd FileType php nmap <silent> <leader>tu :call SwitchBetweenFiles('php', 'src/Tests/', 'src/', 'Test', 'src', ':sp'  )<cr>
" Those autocmd are in the private file projects.nvirmc. I source it from my
" personnal Nextcloud
function! php#SwitchBetweenFiles(fileExtension, firstDirBeginning, secondDirBeginning, filenameAddition, ...)
    let f = bufname("%")
    if exists("a:2")
        let openFileCommand = a:2
    else
        let openFileCommand = ":e"
    endif

    if f =~ '.'.a:fileExtension
        if f =~ '\<'.a:firstDirBeginning && f =~ a:filenameAddition.'\.'.a:fileExtension
            let filename = substitute(substitute(f, a:firstDirBeginning, '', ''), a:filenameAddition, '', '')

            if exists("a:1") && !empty(a:1)
                let filename = a:1.'/'.filename
            endif

            if !filereadable(filename)
                let new_dir = substitute(filename, '/\w\+\.'.a:fileExtension, '', '')
                exe ":!mkdir -p ".new_dir
            endif

            exe openFileCommand." ".filename

        elseif f =~ '\<'.a:secondDirBeginning && f !~ a:filenameAddition.'\.'.a:fileExtension
            let filename = substitute(substitute(f, a:secondDirBeginning, a:firstDirBeginning.a:secondDirBeginning, ''), '.'.a:fileExtension, a:filenameAddition.'.'.a:fileExtension, '')

            if exists("a:1") && !empty(a:1)
                let filename = substitute(filename, '/'.a:1, '', '')
            endif

            if !filereadable(filename)
                let new_dir = substitute(filename, '/\w\+'.a:filenameAddition.'\.'.a:fileExtension, '', '')
                exe ":!mkdir -p ".new_dir
            endif
            exe openFileCommand." ".filename
        else
            echom "Could not switch because needed patterns not matched."
        endif
    endif
endfunction
