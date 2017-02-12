" nerdtree configuration
nmap <leader>n :NERDTreeToggle<CR>

" don't display informations (type ? for help and so on)
let g:NERDTreeMinimalUI = 1
" don't replace the native vim file explorer
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeChDirMode = 2
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeCascadeOpenSingleChildDir = 1

" change the arrows
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
