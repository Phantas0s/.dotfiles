if !1 | finish | endif

" Declare group for autocmd for whole init.vim, and clear it
" Otherwise every autocmd will be added to group each time vimrc sourced!
augroup vimrc
    autocmd!
augroup END

" +----------------+
" | install plugin |
" +----------------+

source $VIMCONFIG/init_plugins.vim

" source every plugin configs
for file in split(glob("$VIMCONFIG/pluggedconf/*.nvimrc"), '\n')
    execute 'source' file
endfor

" +---------------+
" | plugin config |
" +---------------+

let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
" let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}

" if exists("g:did_load_filetypes")
"   filetype off
"   filetype plugin indent off
" endif
" set runtimepath+=$VIMCONFIG/godoctor.vim
" filetype on
" filetype plugin indent on

" Impossible to put it in vim-delve.nvimrc file...
let g:delve_breakpoint_sign = ""
let g:delve_tracepoint_sign = ""

" project config - personnal file (not on my git repository)
source $VIMCONFIG/projects.nvimrc

" close the buffer
nnoremap <silent> <leader>db <cmd>bp <bar>bd #<cr> 

" Coc extensions
let g:coc_global_extensions = [
            \ 'coc-css', 
            \ 'coc-html',
            \ 'coc-json', 
            \ 'coc-yaml', 
            \ 'coc-godot', 
            \ 'coc-sql', 
            \ 'coc-db',
            \ 'coc-snippets',
            \ 'coc-phpactor',
            \ 'coc-php-cs-fixer',
            \ 'coc-tsserver',
            \ 'coc-eslint',
            \ 'coc-pyright',
            \ 'coc-metals',
            \]

" \ 'coc-snippets',
" \ 'coc-markmap',
" \ 'coc-sh',

let g:vim_markdown_folding_disabled = 1
" }}}
" General Bindings ---------------------- {{{

" +-----------------+
" | general binding |
" +-----------------+

syntax on

" weird hack for nerdtree to work
let mapleader = "\\"
let maplocalleader = "\\"
map <space> <leader>
map <space> <localleader>

" Stop undo at each space
" Doesn't work with abbreviations...
" inoremap <space> <C-G>u<space>

vmap <F2> !boxes -d stone " to create boxes!!
vmap <f3> !figlet<CR> " to create ascii art!!
map <silent> <esc> <Cmd>noh<cr> " un-highlight when esc is pressed

" indent without killing the selection in VISUAL mode
vmap < <gv
vmap > >gv

" location & quickfix window
nnoremap <silent> <leader>l :call general#ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>q :call general#ToggleList("Quickfix List", 'c')<CR>

" open relative paths under cursor with xdg-open (example: './my/relative/file.pdf')
nnoremap <silent> gX :execute
            \ "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>

" Fix gx for URLs
nmap <silent> gx yiW:!xdg-open <C-r>" & <CR><CR>
vmap <silent> gx y:!xdg-open <C-r>" & <CR><CR>

"toggle between absolute -> relative line number
nnoremap <C-n> :let [&nu, &rnu] = [&nu, &nu+&rnu==1]<CR>

" tabs
nnoremap th :tabfirst<CR>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap tl :tablast<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>

" move tab to first position
nnoremap tH :tabm 0<CR>
nnoremap tL :tabm<CR>

" windows navigation
" use ctrl + hjkl

" create horizontal window
nnoremap <c-w>h <c-w>s

" delete character after cursor in insert mode
inoremap <C-l> <Del>

" highlight the line which is longer than the defined margin (120 character)
highlight MaxLineChar ctermbg=red
autocmd vimrc FileType php,js,vue,go call matchadd('MaxLineChar', '\%120v', 100)
" Autocmd test
" autocmd vimrc FileType markdown call general#MakeJournalEntry()

" open devdocs.io with firefox and search the word under the cursor

" Multi OS version (open for macOS)
" command -nargs=? DevDocs call system('type -p open >/dev/null 2>&1 && open https://devdocs.io/#q=<args> || xdg-open https://devdocs.io/#q=<args>')

" Only Linux
command! -nargs=? DevDocs call system('xdg-open https://devdocs.io/#q=<args>')
autocmd vimrc FileType python,ruby,rspec,javascript,go,html,php nnoremap <buffer><leader>D :execute "DevDocs " . expand('<cword>')<CR>
" same but with clojuredocs
" same but with scaladocs

" arrow keys resize windows
nnoremap <Left> :vertical resize -10<CR>
nnoremap <Right> :vertical resize +10<CR>
nnoremap <Up> :resize -10<CR>
nnoremap <Down> :resize +10<CR>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Quit neovim terminal
tnoremap <C-\> <C-\><C-n>

" buffer cleanup - delete every buffer except the one open
command! Ball :silent call general#Bdeleteonly()

" Add a journal entry
command! Jrnl call general#MakeJournalEntry()

" restore the position of the last cursor when you open a file
autocmd vimrc BufReadPost * call general#RestorePosition()

" edit vimrc with f5 and source it with f6
nnoremap <silent> <leader><f5> :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader><f6> :source $MYVIMRC<CR>

" delete trailing space when saving files
autocmd vimrc BufWrite *.php,*.js,*.jsx,*.vue,*.twig,*.html,*.sh,*.yaml,*.yml,*.clj,*.cljs,*.cljc call general#DeleteTrailingWS()

" Simple Zoom / Restore window (like Tmux)
nnoremap <silent> <leader>z :call general#ZoomToggle()<CR>

" Open files with external application
autocmd vimrc BufEnter *.png,*.jpg,*.gif silent! execute "! sxiv ".expand("%") | bwipeout
autocmd vimrc BufEnter *.pdf silent! execute "! zathura ".expand("%") "&" | bwipeout

" Execute a macro for the all selection
xnoremap @ :<C-u>call general#ExecuteMacroOverVisualRange()<CR>

" Disable anoying ex mode
nnoremap Q <Nop>

" Y behave like D
nnoremap Y y$

" Save files as root
cnoremap w!! execute ':w suda://%'

" Save session
nnoremap <leader>ss :mksession! $VIMCONFIG/sessions/
" Reload session
nnoremap <leader>sl :source $VIMCONFIG/sessions/

" Set tmTheme and mm extensions as XML
autocmd vimrc BufNewFile,BufRead *.tmTheme, *.mm set filetype=xml

" }}}

" abbreviations ---------------------- {{{

" +---------------+
" | Abbreviations |
" +---------------+

iabbrev IMO in my opinion
iabbrev BTW by the way
iabbrev <expr> cdate strftime('%Y-%m-%d') "current date

" }}}

" Set options ---------------------- {{{

" +--------------+
" | Set  options |
" +--------------+

" colorscheme
colorscheme hypnos

" no swap file
set noswapfile
" set the directory where the swap file will be saved
set backupdir=$VIMCONFIG/backup
set directory=$VIMCONFIG/swap

" save undo trees in files
set undofile
set undodir=$VIMCONFIG/undo

" number of undo saved
set undolevels=10000 " How many undos
set undoreload=10000 " number of lines to save for undo

" set line number
set number

" the copy goes to the clipboard
set clipboard+=unnamedplus

" use 4 spaces instead of tab (to replace existing tab use :retab)
" copy indent from current line when starting a new line
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" when at 3 spaces, and I hit > ... indent of 4 spaces in total, not 7
set shiftround

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" set list
set list listchars=tab:\┆\ ,trail:·,nbsp:±

" doesn't prompt a warning when opening a file and the current file was modified but not saved 
set hidden

" avoid delay
" redir doesn't work anymore with that...
" set updatetime=300

" always show signcolumns
set signcolumn=yes

" don't give |ins-completion-menu| messages.
set shortmess+=c

" doesn't display the mode status
" set noshowmode

" Keep cursor more in middle when scrolling down / up
set scrolloff=999

" write automatically when quitting buffer
set autowrite

" Fold related
set foldlevelstart=0 " Start with all folds closed
set foldtext=general#FoldText()

" Show the substitution LIVE
set inccommand=nosplit

" Better ex autocompletion
" set wildmenu
" set wildmode=list:longest,full

" relative / hybrid line number switch
set number relativenumber

" for vertical pane in git diff tool
set diffopt+=vertical

set shada=!,'100,<50,s100,h

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

autocmd vimrc FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

if executable('rg')
    set grepprg=rg\ --vimgrep
endif

" }}}
