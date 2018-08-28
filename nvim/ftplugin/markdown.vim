" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/md/*.nvimrc"), '\n')
    exe 'source' file
endfor

set number norelativenumber

augroup mdnumbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set norelativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
