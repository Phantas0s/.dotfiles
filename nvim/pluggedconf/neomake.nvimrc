" +---------+
" | General |
" +---------+

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
if isdirectory($VIMCONFIG . "/plugged/neomake")
    call neomake#configure#automake('w')
endif

command! -bang -nargs=* -complete=file Make NeomakeProject <args>

" +-----+
" | PHP |
" +-----+

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

" let g:neomake_php_phpstan_maker = {
"             \ 'args': ['analyse', '--error-format', 'raw', '--no-progress', '--level', '7'],
"             \ 'errorformat': '%W%f:%l:%m',
"             \ 'postprocess': function('SetWarningType'),
"             \ }
" let g:neomake_php_phpmd_maker = {
"             \ 'args': ['%:p', 'text', 'cleancode,codesize,design,unusedcode,naming'],
"             \ 'errorformat': '%W%f:%l%\s%\s%#%m',
"             \ 'postprocess': function('SetMessageType'),
"             \ }

" let g:neomake_php_psalm_maker = {
"         \ 'args': [
"             \ '--output-format=pylint'
"         \ ],
"         \ 'errorformat': '%A%f:%l:%\s[%t%n]%\s%m',
"         \ 'postprocess': function('SetWarningType'),
"         \ }

" +------------+
" | JavaScript |
" +------------+

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

" Call neomake#Make directly instead of the Neomake provided command
if has('nvim')
    autocmd vimrc BufWritePost *.js,*.jsx :silent :call neomake#Make(1, [], function('s:Neomake_callback'))
endif

" +--------+
" | Golang |
" +--------+

let g:neomake_go_enabled_makers = [ 'go']
let g:neomake_go_golangci_maker = {
            \ 'exe': 'golangci-lint',
            \ 'args': [ 'run', '--enable=unparam' ],
            \ 'append_file': 0,
            \ 'cwd': '%:h',
            \ 'postprocess': function('SetWarningType')
            \ }

let g:neomake_go_golangcifast_maker = {
            \ 'exe': 'golangci-lint',
            \ 'args': [ 'run', '--fast', ],
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

" +----+
" | sh |
" +----+

let g:neomake_sh_enabled_makers = ['shellcheck']

" +-----+
" | SQL |
" +-----+

let g:neomake_sql_enabled_makers = ['sqlint']

" +------+
" | Yaml |
" +------+

let g:neomake_yaml_enabled_makers = [ 'yamllint' ]

" +---------------+
" | Racket (Lisp) |
" +---------------+

let g:neomake_scheme_enabled_makers = ['raco']

let g:neomake_scheme_raco_maker = {
            \ 'exe': 'raco',
            \ 'args': ['expand'],
            \ 'errorformat': '%-G %.%#,%E%f:%l:%c: %m'
            \ }


" +----------------+
" | Clojure (Lisp) |
" +----------------+

let g:neomake_clojure_enabled_makers = ['kondo']

let g:neomake_clojure_kondo_maker = {
    \ 'exe': 'clj-kondo',
    \ 'args': ['--lint', '%'],
    \ 'errorformat': '%f:%l:%c:\ Parse\ %t%*[^:]:\ %m,%f:%l:%c:\ %t%*[^:]:\ %m',
    \ }

let g:neomake_clojure_joker_maker = {
    \ 'exe': 'joker',
    \ 'args': ['--lint', '%'],
    \ 'errorformat': '\v^[a-zA-Z]?:?[^:]+:(\d+):(\d+):? ((Read error|Parse error|Parse warning|Exception): ?(.+))$',
    \ }

" +-----------+
" | VimScript |
" +-----------+

let g:neomake_vim_enabled_makers = ['vint']

" +----------+
" | Markdown |
" +----------+

" Crash too often
" let g:neomake_markdown_enabled_makers = ['proselint'] 

" +-------------+
" | Spinner !!! |
" +-------------+

let s:spinner_index = 0
let s:active_spinners = 0
let s:spinner_states = ['|', '/', '--', '\', '|', '/', '--', '\']
let s:spinner_states = ['┤', '┘', '┴', '└', '├', '┌', '┬', '┐']
let s:spinner_states = ['←', '↑', '→', '↓']
let s:spinner_states = ['d', 'q', 'p', 'b']
let s:spinner_states = ['■', '□', '▪', '▫', '▪', '□', '■']
let s:spinner_states = ['→', '↘', '↓', '↙', '←', '↖', '↑', '↗']
let s:spinner_states = ['.', 'o', 'O', '°', 'O', 'o', '.']

function! StartSpinner()
    let b:show_spinner = 1
    let s:active_spinners += 1
    if s:active_spinners == 1
        let s:spinner_timer = timer_start(1000 / len(s:spinner_states), 'SpinSpinner', {'repeat': -1})
    endif
endfunction

function! StopSpinner()
    let b:show_spinner = 0
    let s:active_spinners -= 1
    if s:active_spinners == 0
        :call timer_stop(s:spinner_timer)
    endif
endfunction

function! SpinSpinner(timer)
    let s:spinner_index = float2nr(fmod(s:spinner_index + 1, len(s:spinner_states)))
    redraw
endfunction

function! SpinnerText()
    if get(b:, 'show_spinner', 0) == 0
        return " "
    endif

    return s:spinner_states[s:spinner_index]
endfunction

augroup neomake_hooks
    au!
    autocmd User NeomakeJobInit :call StartSpinner()
    autocmd User NeomakeFinished :call StopSpinner()
    " autocmd User NeomakeFinished :echom "Build complete"
augroup END

