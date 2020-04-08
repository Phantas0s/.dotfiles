autocmd FileType clojure nmap <buffer>E cpp
autocmd FileType clojure nmap <buffer>K :exec "Doc ".expand("<cword>")<cr>
autocmd FileType clojure nmap <buffer><leader>S :exec "Source ".expand("<cword>")<cr>
