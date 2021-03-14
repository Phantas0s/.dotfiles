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

noremap <silent> <F8> :<C-u>NextWordy<cr>
xnoremap <silent> <F8> :<C-u>NextWordy<cr>
