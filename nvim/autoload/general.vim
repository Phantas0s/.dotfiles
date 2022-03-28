" Restore position of the cursor when reopening a file
function general#RestorePosition()
    lua require('hypnos/general').restore_position()

    " Possible
    "lua require'hypnos/general'.restore_position()

    " Other way to call the lua function (need to asign function to a variable before calling it)
    " let RestorePosition = luaeval('require("general/restore_position").restore_position')
    " call RestorePosition()
endfunc

" delete trailing space when saving files
function general#DeleteTrailingWS()
    lua require('hypnos/general').del_trailing_ws()
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

" Simple Zoom / Restore window (like Tmux)
function general#ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
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

function general#WordCount() abort
    if (&ft!="markdown")
        return ""
    endif

    let currentmode = mode()
    if !exists("g:lastmode_wc")
        let g:lastmode_wc = currentmode
    endif
    " if we modify file, open a new buffer, be in visual ever, or switch modes
    " since last run, we recompute.
    if (&modified || !exists("b:wordcount") || currentmode =~? '\c.*v' || currentmode != g:lastmode_wc) && currentmode != 's'
        let g:lastmode_wc = currentmode
        let l:old_position = getpos('.')
        let l:old_status = v:statusmsg
        execute "silent normal g\<c-g>"
        if v:statusmsg == "--No lines in buffer--"
            let b:wordcount = 0
        else
            let s:split_wc = split(v:statusmsg)
            if index(s:split_wc, "Selected") < 0
                let b:wordcount = str2nr(s:split_wc[11])
            else
                let b:wordcount = str2nr(s:split_wc[5])
            endif
            let v:statusmsg = l:old_status
        endif
        call setpos('.', l:old_position)
        return "Words " . b:wordcount . " "
    else
        return "Words " . b:wordcount . " "
    endif
endfunction

function general#CharCount()
    if (&ft!="markdown")
        return ""
    endif

    let currentmode = mode()
    if !exists('g:lastmode_wc')
        let g:lastmode_wc = currentmode
    endif
    " if we modify file, open a new buffer, be in visual ever, or switch modes
    " since last run, we recompute.
    if (&modified || !exists('b:charcount') || currentmode =~? '\c.*v' || currentmode != g:lastmode_wc) && currentmode != 's'
        let g:lastmode_wc = currentmode
        let l:old_position = getpos('.')
        let l:old_status = v:statusmsg
        execute "silent normal g\<c-g>"
        if v:statusmsg ==? '--No lines in buffer--'
            let b:charcount = 0
        else
            let s:split_wc = split(v:statusmsg)
            if index(s:split_wc, 'Selected') < 0
                let b:charcount = str2nr(s:split_wc[13]) - 1
            else
                let b:charcount = str2nr(s:split_wc[9]) - 1
            endif
            let v:statusmsg = l:old_status
        endif
        call setpos('.', l:old_position)
        return b:charcount
    else
        return b:charcount
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

" output Ex command in buffer
function general#Vsystem(excmds)
    redir => s:results
    exec a:excmds
    redir END
    return s:results
endfunction

" See: https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
function general#Redir(cmd, rng, start, end)
    " Close all the windows of current tabpage if it has a variable "win" attached
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let cmd = a:cmd =~' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
		if a:rng == 0
			let output = systemlist(cmd)
		else
			let joined_lines = join(getline(a:start, a:end), '\n')
			let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
			let output = systemlist(cmd . " <<< $" . cleaned_lines)
		endif
	else
		redir => output
		execute a:cmd
		redir END
		let output = split(output, "\n")
	endif
	vnew
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, output)
endfunction

" Alternative version - to test
" Redirect the output of a Vim or external command into a scratch buffer
" function! Redir(cmd) abort
"     let output = execute(a:cmd)
"     tabnew
"     setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
"     call setline(1, split(output, "\n"))
" endfunction
" command! -nargs=1 Redir silent call Redir(<f-args>)

function! general#SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
