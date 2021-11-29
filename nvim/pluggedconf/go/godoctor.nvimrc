" Moved to init.vim
" if exists("g:did_load_filetypes")
"   filetype off
"   filetype plugin indent off
" endif
" filetype plugin indent on
" syntax on

" vimdoctor 
xnoremap <buffer><localleader>rem :Refactor extract
xnoremap <buffer><localleader>rev :Refactor var
xnoremap <buffer><localleader>ret :Refactor toggle
noremap <buffer><localleader>rgd :Refactor godoc<cr>
