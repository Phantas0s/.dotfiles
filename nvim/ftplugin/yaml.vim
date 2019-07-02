augroup yaml
  autocmd!
augroup END

if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

setlocal autoindent sw=2 et
setlocal indentexpr=yaml#GetYamlIndent()
setlocal indentkeys=o,O,*<Return>,!^F

autocmd yaml FileType yaml setlocal ai ts=2 sw=2 et colorcolumn=1,3,5,7,9,11,13 nu

let g:tagbar_type_ansible = {
	\ 'ctagstype' : 'ansible',
	\ 'kinds' : [
		\ 't:tasks'
	\ ],
	\ 'sort' : 0
\ }
