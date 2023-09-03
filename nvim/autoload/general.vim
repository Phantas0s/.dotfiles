" Restore position of the cursor when reopening a file
" Possible
    "lua require'hypnos/general'.restore_position()

" Other way to call the lua function (need to asign function to a variable before calling it)
" let RestorePosition = luaeval('require("general/restore_position").restore_position')
" call RestorePosition()
function general#RestorePosition()
    lua require('hypnos/general').restore_position()
endfunc

" delete trailing space when saving files
function general#DeleteTrailingWS()
    lua require('hypnos/general').del_trailing_ws()
endfunc

" make the current window fullscreen
function general#ZoomToggle()
    lua require('hypnos/general').zoom_toggle()
endfunc

" redirect some Ex command output to a scratch buffer
function general#Redir(cmd, rng, start, end)
    let Redir = luaeval('require("hypnos/redir").redir')
    echom a:cmd
    call Redir(a:cmd)
endfunc

" buffer cleanup - delete every buffer except the one open
function general#Buflist() abort
    redir => bufnames
    silent ls
    redir END
    let list = []
    for i in split(bufnames, "\n")
        let buf = split(i, '"' )
        call add(list, buf[-2])
    endfor
    return list
endfunction

function general#Bdeleteonly() abort
    let list = filter(general#Buflist(), 'v:val != bufname("%")')
    call general#DeleteEmptyBuffers()
    for buffer in list
        exec 'bdelete '.buffer
    endfor
endfunction

function general#DeleteEmptyBuffers() abort
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
    if !empty(buffers)
        exe 'bdelete '.join(buffers, ' ')
    endif
endfunction

function general#FoldText() abort
    let line=getline(v:foldstart)
    let nucolwidth=&foldcolumn+&number*&numberwidth
    let windowwidth=winwidth(0)-nucolwidth-3
    let foldedlinecount=v:foldend-v:foldstart+1
    let onetab=strpart('          ', 0, &tabstop)
    let line=substitute(line, '\t', onetab, 'g')
    let line=strpart(line, 0, windowwidth-2-len(foldedlinecount))
    let fillcharcount=windowwidth-len(line)-len(foldedlinecount)
    return line.'…'.repeat(' ',fillcharcount).foldedlinecount.'L'.' '
endfunction

function general#ExecuteMacroOverVisualRange() abort
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

" For use with pressing * or # in visual mode to search for current selection
function general#VisualSelection(direction, extra_filter) range abort
    let l:saved_reg = @"
    execute 'normal! vgvy'

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", '', '')

    if a:direction is# 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction is# 'replace'
        call CmdLine('%s' . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" to toggle quickfix list and location list
function general#GetBufferList() abort
    redir =>buflist
    silent! ls!
    redir END
    return buflist
endfunction

function general#ToggleList(bufname, pfx)
    let buflist = general#GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
            exec(a:pfx.'close')
            return
        endif
    endfor
    if a:pfx == 'l' && len(getloclist(0)) == 0
        echohl ErrorMsg
        echo "Location List is Empty."
        return
    endif
    let winnr = winnr()
    exec(a:pfx.'open')
    if winnr() != winnr
        wincmd p
    endif
endfunction

" create a dedicated file and prepare for writing it with markdown.
function general#MakeJournalEntry()
    cd $JRNL
    let fname = $JRNL . '/' . strftime('%Y_%m_%d.md')
    execute 'edit ' . fname
    if filereadable(fname) ==? v:false
        execute 'normal I# ' . strftime('%A, the %d of %B %Y')
    endif
    execute "normal! Go\<cr>## " . strftime('%H:%M')
    execute "normal! o\<cr>"
    startinsert
endfunction

function! general#SynStack()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
endfunc
