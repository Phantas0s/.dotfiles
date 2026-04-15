" Words lowercased by Chicago Manual of Style (CMOS):
" - Coordinating conjunctions: for, and, nor, but, or
" - Articles: a, an, the
" - Prepositions up to 4 letters: at, by, in, of, on, to, up, as, if,
"   off, per, via, for, from, into, like, near, once, onto, over, past,
"   than, that, till, upon, with
let s:cmos_lowercase = [
  \ 'a', 'an', 'the',
  \ 'and', 'but', 'for', 'nor', 'or',
  \ 'as', 'at', 'by', 'if', 'in', 'of', 'on', 'per', 'to', 'up', 'via',
  \ 'for', 'from', 'into', 'like', 'near', 'off', 'once', 'onto',
  \ 'over', 'past', 'than', 'that', 'till', 'upon', 'with'
  \ ]

function! s:Capitalize(word) abort
  if len(a:word) == 0
    return a:word
  endif
  return toupper(strpart(a:word, 0, 1)) . tolower(strpart(a:word, 1))
endfunction

function! s:ApplyCMOS(words) abort
  let result = []
  let n = len(a:words)

  " Find index of first word that contains a letter
  let first_word_idx = 0
  for i in range(n)
    if a:words[i] =~# '[a-zA-Z]'
      let first_word_idx = i
      break
    endif
  endfor

  " Find index of last word that contains a letter
  let last_word_idx = 0
  for i in range(n - 1, 0, -1)
    if a:words[i] =~# '[a-zA-Z]'
      let last_word_idx = i
      break
    endif
  endfor

  for i in range(n)
    let word = a:words[i]
    let lower = tolower(word)

    if i == first_word_idx || i == last_word_idx || index(s:cmos_lowercase, lower) == -1
      call add(result, s:Capitalize(word))
    else
      call add(result, lower)
    endif
  endfor

  return join(result, ' ')
endfunction

function! markdown#TitleCase() abort
  let saved = @"
  normal! gvy
  let title = @"

  let words = split(title)
  let result = s:ApplyCMOS(words)

  let @" = result
  normal! gvp
  let @" = saved
endfunction
