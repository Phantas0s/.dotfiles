autocmd FileType go nmap <buffer><leader>db :exec "DlvToggleBreakpoint"<cr>
autocmd FileType go nmap <buffer><leader>dc :exec "DlvClearAll"<cr>
autocmd FileType go nmap <buffer><leader>dr :exec "DlvDebug"<cr>

let g:delve_breakpoint_sign = "+"
let g:delve_tracepoint_sign = "+"

