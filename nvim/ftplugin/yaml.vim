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

autocmd yaml FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
