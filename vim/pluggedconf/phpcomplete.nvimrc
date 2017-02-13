" write ctags each time we change a php file
au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags'
let g:phpcomplete_parse_docblock_comments = 1
