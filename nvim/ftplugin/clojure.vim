" source every plugin configs
for file in split(glob($XDG_CONFIG_HOME . "/nvim/pluggedconf/clojure/*.nvimrc"), '\n')
    exe 'source' file
endfor

for file in split(glob($XDG_CONFIG_HOME . "/nvim/pluggedconf/lisp/*.nvimrc"), '\n')
    exe 'source' file
endfor

map <buffer><leader>su ysi

command! -buffer -nargs=? ClojureDoc call system('xdg-open "https://clojuredocs.org/search\?q=<args>"')
nnoremap <buffer><leader>D :execute "ClojureDoc " . expand('<cword>')<CR>
