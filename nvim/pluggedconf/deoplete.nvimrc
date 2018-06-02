" deoplete config

" start automatically
let g:deoplete#enable_at_startup = 1

" deoplete tab-complete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:deoplete#file#enable_buffer_path = 1

" For js - doesn't work
" let g:deoplete#omni#functions = {}
" let g:deoplete#omni#functions.javascript = [
"   \ 'tern#Complete',
"   \ 'jspc#omni'
" \]

" delay for auto complete and refresh
let g:deoplete#auto_complete_delay= 75
let g:deoplete#auto_refresh_delay= 5
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1

set completeopt -=preview
