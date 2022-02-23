" Vim compiler file
" Compiler:	love

if exists('current_compiler')
  finish
endif
let current_compiler = 'love'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpoptions
set cpoptions-=C

CompilerSet makeprg=love\ .
CompilerSet errorformat=Error:%*[^:]:\ %f:%l:%m,Error:\ %f:%l:%m,%f:%l:%m

let &cpoptions = s:save_cpo
unlet s:save_cpo

" vim: sw=2 sts=2 et
