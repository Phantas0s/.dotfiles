autocmd FileType go nnoremap <buffer><F9> :exec "DlvToggleTracepoint"<cr>
autocmd FileType go nnoremap <buffer><F10> :exec "DlvToggleBreakpoint"<cr>
autocmd FileType go nnoremap <buffer><F11> :exec "DlvClearAll"<cr>
" for go debug run
autocmd FileType go nmap <buffer><F5> :exec "DlvDebug"<cr>
autocmd FileType go nmap <buffer><F6> :exec "DlvTest"<cr> " possible to call DlvTest --build-flags="--tags=integration" using tags for separating integration / unit tests

