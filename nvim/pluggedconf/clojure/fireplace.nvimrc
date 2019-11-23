autocmd FileType clojure nmap <buffer><leader>E :Eval<cr>
autocmd FileType clojure nmap <buffer><leader>K :exec "Doc ".expand("<cword>")<cr>

