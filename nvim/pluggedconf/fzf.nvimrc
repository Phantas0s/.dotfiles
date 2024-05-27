augroup fzf
  autocmd!
augroup END

" Key mapping

" History of file opened
nnoremap <leader>h :History<cr>

" Buffers opens
nnoremap <leader>b :Buffers<cr>

" Files recursively from pwd
" Everything except gitignore files
nnoremap <leader>f :Files<cr>
nnoremap <leader>F :GFiles --cached --others --exclude-standard<cr>

" Ex commands
nnoremap <leader>c :Commands<cr>
" Ex command history. <C-e> to modify the command
nnoremap <leader>: :History:<cr>

nnoremap <leader>a :Rgi<space>
nnoremap <leader>A :exec "Rgi ".expand("<cword>")<cr>

"" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)

" ripgrep command to search in multiple files
command! -bang -nargs=* Rg call fzf#vim#grep(
  \   'rg
        \ --column
        \ --line-number
        \ --no-heading
        \ --fixed-strings
        \ --ignore-case
        \ --hidden
        \ --follow
        \ --glob "!.git/*"
        \ --color "always" '.shellescape(<q-args>),
  \   fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" ripgrep - ignore the files defined in ignore files (.gitignore...)
command! -bang -nargs=* Rgi call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>),
  \   fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" ripgrep - ignore the files defined in ignore files (.gitignore...) and doesn't ignore case
command! -bang -nargs=* Rgic call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>),
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" ripgrep - ignore the files defined in ignore files (.gitignore...) and doesn't ignore case
command! -bang -nargs=* Rgir call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --hidden --no-ignore --follow --glob "!.git/*" --color "always" '.fzf#shellescape(<q-args>),
  \   fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Customize fzf colors to match the current color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Search'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Visual'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'StatusLineNC'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" ALT-A CTRL-Q to select all and build quickfix list
" https://github.com/junegunn/fzf.vim/issues/185
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" Build a quickfix list when multiple files are selected
let g:fzf_action = {
  \ 'ctrl-x': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

" nmap <leader><tab> <plug>(fzf-maps-n)

let s:git_add_cmd='git ls-files --modified --deleted --other --exclude-standard --deduplicate $(git rev-parse --show-toplevel)'
command! -bang GitAdd call fzf#run(fzf#wrap({
    \ 'source': s:git_add_cmd,
    \ 'options': [
        \ '--multi',
        \ '--multi',
        \ '--reverse',
        \ '--no-sort',
        \ '--prompt', 'Add > ',
        \ '--preview', 'git status --short',
        \ '--bind', 'enter:execute(git add {+})',
        \ '--bind', 'enter:+reload('.s:git_add_cmd.')',
    \ ]}))

  " --bind='f1:toggle-header' \
  " --bind='f2:toggle-preview' \
  " --bind='enter:+refresh-preview' \
  " --header-first \
  " --header='ENTER to stage the file'
