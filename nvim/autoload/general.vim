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

function general#GitBlame()
    lua require('hypnos/general').git_blame()
endfunc

function general#CloseFloat()
    lua require('hypnos/general').close_floating_windows()
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
        execute 'bdelete '.buffer
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
