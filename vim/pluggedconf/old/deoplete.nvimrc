" deoplete config

" start automatically
let g:deoplete#enable_at_startup = 1

" deoplete tab-complete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:deoplete#file#enable_buffer_path = 1

" Compatibility with phpcomplete
let g:deoplete#omni_patterns = {}

let g:deoplete#sources = {}
let g:deoplete#sources.php = ['padawan', 'ultisnips', 'buffer']

" delay for auto complete and refresh
let g:deoplete#auto_complete_delay= 75
let g:deoplete#auto_refresh_delay= 5
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
