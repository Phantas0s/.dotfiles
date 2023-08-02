" Vim compiler file
" Interpreter: lua

if exists('current_compiler')
  finish
endif
let current_compiler = 'lua'

" For old Vim version, define CompilerSet if it doesn't exists
" CompilerSet setlocal for compiler and global for compiler!
if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=lua
CompilerSet errorformat=lua:\ %f:%l:\ %m

" vim: sw=2 sts=2 et
