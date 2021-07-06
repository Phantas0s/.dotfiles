nnoremap <buffer><silent><leader>[ <Plug>(coc-definition)

command! -nargs=? ScalaDoc call system('xdg-open "https://www.scala-lang.org/api/current/?search=<args>"')
nnoremap <buffer><leader>D :execute "ScalaDoc " . expand('<cword>')<CR>
