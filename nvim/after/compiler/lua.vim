" Vim compiler file
" Compiler:	lua

if exists('current_compiler')
  finish
endif
let current_compiler = 'lua'

" For old Vim version, define CompilerSet if it doesn't exists
" CompilerSet setlocal for compiler and global for compiler!
if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpoptions
set cpoptions-=C

CompilerSet makeprg=lua\ .
CompilerSet errorformat=luac: %f:%l: %m

let &cpoptions = s:save_cpo
unlet s:save_cpo

" vim: sw=2 sts=2 et
