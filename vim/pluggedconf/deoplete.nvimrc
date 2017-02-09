" deoplete config

" start automatically
let g:deoplete#enable_at_startup = 1

" deoplete tab-complete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:deoplete#file#enable_buffer_path = 1

" Compatibility with phpcomplete
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.php = '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" delay for auto complete and refresh
let g:deoplete#auto_complete_delay=10
let g:deoplete#auto_refresh_delay=5
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1

" compatibility with phpcd
" let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
" let g:deoplete#ignore_sources.php = ['omni']
