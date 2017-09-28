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

" call neomake#configure#automake('w')

" display warning for phpcs error
function! SetWarningType(entry)
  let a:entry.type = 'W'
endfunction

function! SetErrorType(entry)
  let a:entry.type = 'E'
endfunction

function! SetMessageType(entry)
  let a:entry.type = 'M'
endfunction


let g:neomake_php_phpcs_maker = {
        \ 'args': ['--report=csv', '--standard=PSR2'],
        \ 'errorformat':
            \ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity%.%#,'.
            \ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]%.%#',
        \ 'postprocess': function('SetWarningType'),
 \ }

let g:neomake_php_phpstan_maker = {
        \ 'args': ['analyse -l 5', '--errorFormat', 'raw'],
        \ 'errorformat': '%E%f:%l:%m',
        \ 'postprocess': function('SetWarningType'),
 \ }

let g:neomake_php_phpmd_maker = {
        \ 'args': ['%:p', 'text', 'cleancode,codesize,design,unusedcode,naming'],
        \ 'errorformat': '%W%f:%l%\s%\s%#%m',
        \ 'postprocess': function('SetMessageType'),
 \ }

