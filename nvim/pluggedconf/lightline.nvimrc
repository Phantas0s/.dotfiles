let g:lightline = {
      \ 'colorscheme': 'hypnos256',
      \ }

function! MyFiletype()
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype. ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
        return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
