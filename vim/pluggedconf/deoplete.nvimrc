" deoplete config

let g:deoplete#enable_at_startup = 1

" deoplete tab-complete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" compatibility with phpcd
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']
