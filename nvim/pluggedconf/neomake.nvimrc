" Neomake signs in the gutter
let g:neomake_error_sign = {'text': '', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {
            \   'text': '',
            \   'texthl': 'NeomakeWarningSign',
            \ }
let g:neomake_message_sign = {
            \   'text': '',
            \   'texthl': 'NeomakeWarningSign',
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

let g:neomake_php_enabled_makers = ['phpmd', 'phpcs', 'phpstan', 'php']

let g:neomake_php_phpcs_maker = {
            \ 'args': ['--report=csv', '--standard=PSR2'],
            \ 'errorformat':
            \ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity%.%#,'.
            \ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]%.%#',
            \ 'postprocess': function('SetWarningType'),
            \ }

let g:neomake_php_phpstan_maker = {
            \ 'args': ['analyse', '--error-format', 'raw', '--no-progress', '--level', '7'],
            \ 'errorformat': '%W%f:%l:%m',
            \ 'postprocess': function('SetWarningType'),
            \ }

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
            \ 'output_stream': 'stdout',
            \ 'postprocess': function('SetErrorType'),
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
        " execute('checktime ' . bufname('%'))
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
let g:neomake_go_enabled_makers = [ 'go', 'golangcifast' ]

let g:neomake_go_golangci_maker = {
        \ 'exe': 'golangci-lint',
        \ 'args': [
            \ 'run',
            \ '--enable-all'
        \ ],
        \ 'append_file': 0,
        \ 'cwd': '%:h',
        \ 'postprocess': function('SetWarningType')
\ }

let g:neomake_go_golangcifast_maker = {
        \ 'exe': 'golangci-lint',
        \ 'args': [
            \ 'run',
            \ '--fast',
        \ ],
        \ 'append_file': 0,
        \ 'cwd': '%:h',
        \ 'postprocess': function('SetWarningType')
\ }

let g:neomake_go_gometalinter_maker = {
        \ 'args': [
          \ '--disable-all',
          \ '--fast',
          \ '--enable=deadcode',
          \ '--enable=unparam',
          \ '--enable=unused',
          \ '--enable=errcheck',
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

nnoremap <leader>gg :Neomake<space>
autocmd FileType go nmap <buffer><leader>go :exec "Neomake golangci"<cr>

"-----------------
" SQL
"-----------------
let g:neomake_sql_enabled_makers = ['sqlint']

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
