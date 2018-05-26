autocmd FileType go nnoremap <buffer><F10> :exec "DlvToggleBreakpoint"<cr>
autocmd FileType go nnoremap <buffer><F11> :exec "DlvClearAll"<cr>
" for go debug run
autocmd FileType go nmap <buffer><F5> :exec "DlvDebug"<cr>

" Variables set up by the plugin before
unlet g:delve_breakpoint_sign
let g:delve_breakpoint_sign = "*"

unlet g:delve_tracepoint_sign
let g:delve_tracepoint_sign = ">"

