let g:lightline = {
      \ 'colorscheme': 'hypnos256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename','gitbranch', 'modified', 'neospinner'] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent', 'wordcount', 'charcount' ], [ 'fileencoding', 'filetype', 'charvaluehex' ] ],
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ 'component_function': {
      \   'wordcount': 'general#WordCount',
      \   'charcount': 'general#CharCount',
      \   'gitbranch': 'fugitive#head',
      \   'neospinner': 'SpinnerText',
      \ },
      \ }
