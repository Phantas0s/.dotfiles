" source every plugin configs
for file in split(glob($XDG_CONFIG_HOME . "/nvim/pluggedconf/md/*.nvimrc"), '\n')
    exe 'source' file
endfor

" cancel the number toggled defined in init file
augroup mdnumbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set norelativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '/usr/bin/markdown2ctags',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

" Write mode
setlocal number norelativenumber
setlocal spell
