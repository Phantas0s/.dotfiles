function! yaml#GetYamlIndent()
  let prevlnum = v:lnum - 1
  if prevlnum == 0
    return 0
  endif
  let line = substitute(getline(v:lnum),'\s\+$','','')
  let prevline = substitute(getline(prevlnum),'\s\+$','','')

  let indent = indent(prevlnum)
  let increase = indent + &sw
  let decrease = indent - &sw

  if prevline =~ ':$'
    return increase
  elseif prevline =~ '^\s\+\-' && line =~ '^\s\+[^-]\+:'
    return decrease
  else
    return indent
  endif
endfunction

