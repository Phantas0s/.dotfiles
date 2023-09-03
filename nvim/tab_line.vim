set tabline=%!TestTabLine()

" tabpagenr($) - Number of tab open
" tabpagenr() - Current tab page
function! TestTabLine()
    let s = ''
    " Loop through all open tabs
    for i in range(tabpagenr('$'))
        let tabIndex = i+1
        " If the tab is the current one, use a specific highlight
        if tabIndex == tabpagenr()
            let s .= '%#TabLineNumSel#'
            let s .= ' ' . tabIndex
            let s .= '%#TabLine#'
        " If not, use another highlight
        else
            let s .= '%#TabLineNum#'
            let s .= ' ' . tabIndex
        endif
        let buflist = tabpagebuflist(i + 1)
        " Loop through each buffer of the tab
        for b in buflist
            " If one buffer is modified, display a star near the tab's index
            if getbufvar(b, "&modified")
                let s .= '*'
            endif
        endfor
        let s .= '%#TabLine#'
    endfor
    return s
endfunction

highlight TabLineSel ctermfg=white ctermbg=black cterm=bold
highlight TabLineNum ctermfg=gray ctermbg=black cterm=NONE
highlight TabLineNumSel ctermfg=red ctermbg=black cterm=bold
highlight TabLine ctermfg=gray ctermbg=black cterm=NONE
