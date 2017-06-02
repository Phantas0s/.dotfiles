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

" standard phpcs config
let g:neomake_php_phpcs_args_standard = 'PSR2'

" update neomake when save file
autocmd! BufWritePost * Neomake

" display warning for phpcs error
function! SetWarningType(entry)
  let a:entry.type = 'W'
endfunction

let g:neomake_php_phpcs_maker = {
        \ 'args': ['--report=csv', '--standard=PSR2'],
        \ 'errorformat':
            \ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity%.%#,'.
            \ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]%.%#',
        \ 'postprocess': function('SetWarningType'),
 \ }

let g:neomake_php_phpstan_maker = {
        \ 'args': ['analyse', '--errorFormat', 'raw'],
        \ 'errorformat': '%E%f:%l:%m',
        \ 'postprocess': function('SetWarningType'),
 \ }
