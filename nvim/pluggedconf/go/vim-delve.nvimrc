autocmd go FileType go nnoremap <buffer><F9> :exec "DlvToggleTracepoint"<cr>
autocmd go FileType go nnoremap <buffer><F10> :exec "DlvToggleBreakpoint"<cr>
autocmd go FileType go nnoremap <buffer><F11> :exec "DlvClearAll"<cr>
" for go debug run
autocmd go FileType go nmap <buffer><F5> :exec "DlvDebug"<cr>
autocmd go FileType go nmap <buffer><F6> :exec "DlvTest"<cr> " possible to call DlvTest --build-flags="--tags=integration" using tags for separating integration / unit tests

