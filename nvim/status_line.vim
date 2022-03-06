function! InsertStatuslineColor(mode)
  if a:mode ==# 'i'
    hi ModeMsg ctermfg=red ctermbg=NONE cterm=bold
  elseif a:mode ==# 'r'
    hi ModeMsg ctermfg=green ctermbg=NONE cterm=bold
  else
    hi ModeMsg ctermfg=yellow ctermbg=NONE cterm=bold
  endif
endfunction

au vimrc InsertEnter * call InsertStatuslineColor(v:insertmode)
au vimrc InsertLeave * hi ModeMsg ctermfg=yellow ctermbg=NONE cterm=bold

" Formats the statusline
set statusline=%r\                      "Read Only flag
set statusline+=%t\                     "Filename
set statusline+=%M\                     "Modified

set statusline+=\ %=                     "ASlign left
set statusline+=%{%general#WordCount()%} "Word counts
set statusline+=%{b:gitbranch}       "Git branch
set statusline+=\ %l/%L\ %p%%            "Line X/Y Percent of file
set statusline+=\ \|\ Buf\ %n            "Buffer
" set statusline+=\ \|\ %{%tolower('%Y')%} "Filetype

" Just a try to put some good Git stuff in the status line (quite useless though)
function! StatuslineGitBranch()
  let b:gitbranch=''
  if &modifiable
    lcd %:p:h
    let l:gitrevparse=system('git rev-parse --abbrev-ref HEAD')
    let l:gitaddedparse=system('command git status --porcelain -b 2> /dev/null | grep -E "^A  |^M  |^MM "')
    let l:gitmodifiedparse=system('command git status --porcelain -b 2> /dev/null | grep -E "^ M |^AM |^MM |^ T "')
    lcd -
    if l:gitrevparse!~#'fatal: not a git repository'
      let b:gitbranch='['.substitute(l:gitrevparse, '\n', '', 'g')
      if l:gitaddedparse!=#''
        let b:gitbranch.= ' +'
      endif
      if l:gitmodifiedparse!=#''
        let b:gitbranch.= ' '
      endif
      let b:gitbranch.='] '
    endif
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END
