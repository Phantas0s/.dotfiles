" Default ring
" let g:wordy#ring = [
"   \ 'weak',
"   \ ['being', 'passive-voice', ],
"   \ 'business-jargon',
"   \ 'weasel',
"   \ 'puffery',
"   \ ['problematic', 'redundant', ],
"   \ ['colloquial', 'idiomatic', 'similies', ],
"   \ 'art-jargon',
"   \ ['contractions', 'opinion', 'vague-time', 'said-synonyms', ],
"   \ 'adjectives',
"   \ 'adverbs',
"   \ ]

noremap <buffer><silent> <F8> :<C-u>NextWordy<cr>
xnoremap <buffer><silent> <F8> :<C-u>NextWordy<cr>
