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
set statusline+=\ %l/%L\ %p%%            "Line X/Y Percent of file
set statusline+=\ \|\ Buf\ %n            "Buffer
" set statusline+=\ \|\ %{%tolower('%Y')%} "Filetype
