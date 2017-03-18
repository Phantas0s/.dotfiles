" Neomake signs in the gutter
     let g:neomake_error_sign = {'text': '', 'texthl': 'NeomakeErrorSign'}
     let g:neomake_warning_sign = {
         \   'text': '',
         \   'texthl': 'NeomakeWarningSign',
         \ }
     let g:neomake_message_sign = {
          \   'text': '➤',
          \   'texthl': 'NeomakeMessageSign',
          \ }
     let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

" update neomake when save file
autocmd! BufWritePost * Neomake

" display warning for phpcs error
function! SetWarningType(entry)
  let a:entry.type = 'W'
endfunction

function! neomake#makers#ft#php#phpcs() abort
    let l:args = ['--report=csv']

    "Add standard argument if one is set.
    if exists('g:neomake_php_phpcs_args_standard')
        call add(l:args, '--standard=' . expand(g:neomake_php_phpcs_args_standard))
    endif

    return {
        \ 'args': args,
        \ 'errorformat':
            \ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity%.%#,'.
            \ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]%.%#',
        \ 'postprocess': function('SetWarningType'),
        \ }
endfunction

" enable markers - verification in order of the arguments
let g:neomake_php_enabled_makers = ['php', 'phpcs']

" Display the error window if a php syntax error is detected
function! OpenQfixIfSyntaxError()
    :w
    :silent setlocal makeprg=php
    :silent make %
    if len(getqflist()) > 0
        :copen
    else
        :cclose
    endif
endfunction

au BufWritePost *.php :call OpenQfixIfSyntaxError()
