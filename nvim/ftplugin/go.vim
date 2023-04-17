augroup go
  autocmd!
augroup END

" use real tabs in .go files, not spaces
setlocal noexpandtab

autocmd go BufWritePre *.go lua vim.lsp.buf.format({async = true})

" source every plugin configs
for file in split(glob($XDG_CONFIG_HOME . "/nvim/pluggedconf/go/*.nvimrc"), '\n')
    exe 'source' file
endfor

" Set the makeprg and errorformat options for go
command! -buffer -bang Compile compiler go | silent make! | cwindow
