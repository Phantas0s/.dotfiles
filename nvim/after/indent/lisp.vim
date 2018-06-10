" Last modified 2017-12-09
" Dorai Sitaram

" This after/indent file is offered for convenience. In a typical
" setting, where this repo is unpacked into your nvim config
" tree, this file will ensure that filetypes 'lisp' and 'scheme'
" use the neoscmindent indenter. (Vim's indent/scheme.vim
" automatically loads all indent/lisp.vim files it finds, so
" there is no need for an after/indent/scheme.vim.)
" 
" You may prefer to set 'inde', etc. for your preferred filetypes
" in your own way.

setl ep=
setl inde=neoscmindent#GetScmIndent(v:lnum)
setl nolisp 
