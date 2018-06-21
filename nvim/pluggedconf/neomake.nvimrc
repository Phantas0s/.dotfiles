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
if isdirectory($HOME . "/nvim/plugged/neomake")
  call neomake#configure#automake('w')
endif


"----------------
" PHP
"-----------------

" standard phpcs config
let g:neomake_php_phpcs_args_standard = 'PSR2'

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

let g:neomake_php_enabled_makers = ['php', 'phpmd', 'phpcs', 'phpstan']

let g:neomake_php_php_maker = {
        \ 'args': ['-l', '-d', 'display_errors=1', '-d', 'log_errors=0',
            \      '-d', 'xdebug.cli_color=0'],
        \ 'errorformat':
            \ '%-GNo syntax errors detected in%.%#,'.
            \ '%EParse error: %#syntax error\, %m in %f on line %l,'.
            \ '%EParse error: %m in %f on line %l,'.
            \ '%EFatal error: %m in %f on line %l,'.
            \ '%-G\s%#,'.
            \ '%-GErrors parsing %.%#',
       \ 'postprocess': function('SetErrorType'),
\ }

let g:neomake_php_phpcs_maker = {
        \ 'args': ['--report=csv', '--standard=PSR2'],
        \ 'errorformat':
            \ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity%.%#,'.
            \ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]%.%#',
        \ 'postprocess': function('SetWarningType'),
 \ }

let g:neomake_php_phpstan_maker = {
        \ 'args': ['analyse', '--errorFormat', 'raw', '--no-progress', '--level', '7'],
        \ 'errorformat': '%E%f:%l:%m',
        \ 'postprocess': function('SetWarningType'),
 \ }

let g:neomake_php_phpmd_maker = {
        \ 'args': ['%:p', 'text', 'cleancode,codesize,design,unusedcode,naming'],
        \ 'errorformat': '%W%f:%l%\s%\s%#%m',
        \ 'postprocess': function('SetMessageType'),
 \ }

"-----------------
" Javascript
"-----------------
let g:neomake_javascript_enabled_makers = ['eslint']
" Use the fix option of eslint

let g:neomake_javascript_eslint_args = ['-f', 'compact', '--fix']
" Callback for reloading file in buffer when eslint has finished and maybe has
" autofixed some stuff
function! s:Neomake_callback(options)
    if (a:options.name ==? 'eslint') && (a:options.has_next == 0)
        execute('edit') 
    endif
endfunction

" function! s:Neomake_callback(options)
"   if (a:options.name ==? 'eslint') && (a:options.has_next == 0)
"     let timer = timer_start(100, 
"           \ {->execute('checktime ' . bufname('%')) }, 
"           \ {'repeat': 20})
"   endif
" endfunction

"
" Call neomake#Make directly instead of the Neomake provided command
autocmd vimrc BufWritePost *.js,*.jsx :silent :call neomake#Make(1, [], function('s:Neomake_callback'))

" if has('nvim')
  " autocmd Filetype javascript call neomake#Make(1, [], function('s:Neomake_callback'))
" endif
"-----------------
" Golang
"-----------------
" let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]

" let g:neomake_go_gometalinter_maker = {
"   \ 'exe': 'zb',
"   \ 'args': [
"   \   'lint',
"   \   '--exclude=unexported',
"   \   '--fast',
"   \ ],
"   \ 'cwd': '%:h',
"   \ 'append_file': 0,
"   \ 'errorformat':
"   \   '%E%f:%l:%c:%trror: %m,' .
"   \   '%W%f:%l:%c:%tarning: %m,' .
"   \   '%E%f:%l::%trror: %m,' .
"   \   '%W%f:%l::%tarning: %m'
" \ }

"   let g:go_fmt_options = {
"     \ 'gofmt': '-s',
" \ }

let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
let g:neomake_go_gometalinter_maker = {
        \ 'args': [
          \ '--disable-all',
          \ '--enable=gas',
          \ '--enable=goconst',
          \ '--enable=golint',
          \ '--enable=ineffassign',
          \ '--enable=maligned',
          \ '--enable=misspell',
          \ '--enable=structcheck',
          \ '--enable=unconvert',
          \ '--enable=varcheck',
          \ '--enable=vet',
          \ '--exclude=unexported',
        \ ],
        \ 'append_file': 0,
        \ 'cwd': '%:h',
        \ 'errorformat':
            \ '%f:%l:%c:%t%*[^:]: %m,' .
            \ '%f:%l::%t%*[^:]: %m',
        \ 'postprocess': function('SetWarningType')
\ }

let g:go_fmt_options = {
  \ 'gofmt': '-s',
  \ }

"-----------------
" Yaml
"-----------------

let g:neomake_yaml_enabled_makers = [ 'yamllint' ]

"-----------------
" Racket (Lisp)
"-----------------
let g:neomake_scheme_enabled_makers = ['raco']

let g:neomake_scheme_raco_maker = {
    \ 'exe': 'raco',
    \ 'args': ['expand'],
    \ 'errorformat': '%-G %.%#,%E%f:%l:%c: %m'
\ }

