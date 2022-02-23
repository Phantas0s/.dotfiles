augroup go
  autocmd!
augroup END

" use real tabs in .go files, not spaces
setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

autocmd go BufWritePre *.go lua vim.lsp.buf.formatting()

" source every plugin configs
for file in split(glob($XDG_CONFIG_HOME . "/nvim/pluggedconf/go/*.nvimrc"), '\n')
    exe 'source' file
endfor

" Set the makeprg and errorformat options for go
command! -buffer -bang Compile compiler go | silent make! | cwindow
