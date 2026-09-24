let g:ale_linters = {
\   'markdown': ['vale'],
\   'tex': ['vale']
\}

let g:ale_enabled = v:false

let g:ale_disable_lsp = 'auto'

let g:ale_virtualtext_cursor = 'current'
let g:ale_use_neovim_diagnostics_api = 0
let g:ale_sign_warning = '--'
let g:ale_sign_error = '!!'
let g:ale_set_highlights = 0
