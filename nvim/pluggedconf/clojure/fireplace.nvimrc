let g:fireplace_cljs_repl = "(adzerk.boot-cljs-repl/repl-env)"

" Eval anything under the cursor
autocmd FileType clojure nmap <buffer><leader>E :exec "Eval ".expand("<cword>")<cr>
autocmd FileType clojure vmap <buffer><leader>E :exec "Eval ".expand("<cword>")<cr>

" Eval s-expression under the cursor
autocmd FileType clojure nmap <buffer><leader>X cpp

" TODO doesn't seem to work with bREPL
autocmd FileType clojure nmap <buffer>K :exec "Doc ".expand("<cword>")<cr>
autocmd FileType clojure nmap <buffer><leader>S :exec "Source ".expand("<cword>")<cr>

" Start REPL for clojurescript
autocmd FileType clojure nmap <buffer><leader>r :exec "Piggieback"<cr>
" Kill REPL 
autocmd FileType clojure nmap <buffer><leader>kr :exec "Piggieback!"<cr>

