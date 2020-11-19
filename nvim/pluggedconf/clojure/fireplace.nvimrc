" DEPRECATED - I don't use Boot anymore
" let g:fireplace_cljs_repl = "(adzerk.boot-cljs-repl/repl-env)"
" command! PiggieBoot :Piggieback (adzerk.boot-cljs-repl/repl-env)

" Connect to a nREPL depending on your build name. See https://github.com/Phantas0s/cljs-bootstrap (I use the build name "dev" in deps.edn).
" TODO would be better to have an environment variable for that? for every names to be consistent.
let g:fireplace_cljs_repl = "(figwheel.main.api/repl-env \"dev\")"
" Start REPL for clojurescript
autocmd FileType clojure nmap <buffer><leader>r :exec "Piggieback"<cr>
" Kill REPL 
autocmd FileType clojure nmap <buffer><leader>kr :exec "Piggieback!"<cr>

" Eval anything under the cursor
" TODO to fix
" autocmd FileType clojure nmap <buffer><leader>E :exec "Eval ".expand("<cword>")<cr>
" autocmd FileType clojure vmap <buffer><leader>E :exec "Eval"

" Eval s-expression (expression inside parentheses) under the cursor
autocmd FileType clojure nmap <buffer><leader>X cpp

" Display the 
autocmd FileType clojure nmap <buffer><leader>K :exec "Doc ".expand("<cword>")<cr>

" Display the source of function / macro but no special forms (doesn't work for "if").
autocmd FileType clojure nmap <buffer><leader>S :exec "Source ".expand("<cword>")<cr>

