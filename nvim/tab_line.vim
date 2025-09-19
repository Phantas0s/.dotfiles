function! TestTabLine()
    let s = ''
    " Range through all tab pages open
    for i in range(tabpagenr('$'))
        let tabIndex = i+1
        " If the tab page is the current one, use a specific highlight
        " If not, use another highlight
        if tabIndex == tabpagenr()
            let s .= '%#TabLineNumSel#'
            let s .= ' ' . tabIndex
        else
            let s .= '%#TabLineNum#'
            let s .= ' ' . tabIndex
        endif
        " Loop through each buffer of the tab page
        let buflist = tabpagebuflist(tabindex)
        let bufname = ''
        let bufmodified = ''
        for b in buflist
            " Display the first buffer of each tab page in the tab line
            if bufname == ''
                let bufname = bufname(bufnr(b))
            endif
            " If one buffer is modified, display a star near the tab's index
            if getbufvar(b, "&modified")
                let bufmodified = '*'
            endif
        endfor
        let s .= bufmodified
        let s .= ' ' .. bufname
        let s .= '%#TabLine#'
    endfor
    return s
endfunction

set tabline=%!TestTabLine()

