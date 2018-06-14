" Moved to init.vim
" if exists("g:did_load_filetypes")
"   filetype off
"   filetype plugin indent off
" endif
" filetype plugin indent on
" syntax on

" vimdoctor 
xnoremap <buffer><leader>rem :Refactor extract
xnoremap <buffer><leader>rev :Refactor var
xnoremap <buffer><leader>ret :Refactor toggle
noremap <buffer><leader>rgd :Refactor godoc<cr>
