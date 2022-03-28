if !1 | finish | endif

" Declare group for autocmd for whole init.vim, and clear it
" Otherwise every autocmd will be added to group each time vimrc sourced!
augroup vimrc
    autocmd!
augroup END

" +------------+
" | leader key |
" +------------+

" Configure leader key
let mapleader = "\<space>"
let maplocalleader = "\<space>"

" +----------------+
" | install plugin |
" +----------------+

" Source plugin definition file
source $VIMCONFIG/init_plugins.vim

" Load custom library for lua
lua require('hypnos/kit')
lua require('hypnos/status_line')
lua require('hypnos/tab_line')
lua require('hypnos/text_objects').basic_text_objects()

" let s:chars = [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`', '?' ]
" for char in s:chars
"     for mode in [ 'xnoremap', 'onoremap' ]
"         execute printf('%s i%s :<C-u>silent normal! T%svt%s<CR>', mode, char, char, char)
"         execute printf('%s a%s :<C-u>normal! F%svf%s<CR>', mode, char, char, char)
"     endfor
" endfor

" source every plugin configs
for file in split(glob("$VIMCONFIG/pluggedconf/*.nvimrc"), '\n')
    execute 'source' file
endfor

" +------------------+
" | global variables |
" +------------------+

let g:vim_markdown_folding_disabled = 1

" New and fast way for detecting filetype
let g:do_filetype_lua = 1

function! Markdonfolds()
    let thisline = getline(v:lnum)
    if match(thisline, '^#') >= 0
        return ">1"
    endif
    return 1
endfunction
" let foldexpr = Markdonfolds()

" Lua syntax highlighting in Vimscript (*.vim) files
let g:vimsyn_embed = 'l;'

" +-----------------+
" | general mapping |
" +-----------------+

" Create box and figlet - ESSENTIAL :D
vmap <F2> !boxes -d stone<cr>
vmap <f3> !figlet<cr>

" un-highlight when esc is pressed
map <silent> <esc> <Cmd>noh<cr>

" indent without killing the selection in VISUAL mode
vmap < <gv
vmap > >gv

inoremap <C-d> <Del>

" location & quickfix
nnoremap <silent> <leader>l :call general#ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>q :call general#ToggleList("Quickfix List", 'c')<CR>
nnoremap <leader>j :cnext<CR>
nnoremap <leader>k :cprevious<CR>
nnoremap <leader>lj :lnext<CR>
nnoremap <leader>lk :lprevious<CR>

" close the current buffer and switch to alternate buffer
nnoremap <silent> <leader>db <cmd>bp <bar>bd! #<cr>

" open relative paths under cursor with xdg-open (example: './my/relative/file.pdf')
nnoremap <silent> gX :execute "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>

" open current file using xdg-open
nnoremap <leader>x :silent :execute "!xdg-open %"<CR>

" Go to file even if doesn't exist
nnoremap gF :e <cfile><CR>

" Create an Ex Command to cd to the current dir - doesn't run it if need to modify it
nnoremap <leader>cd :cd %:p:h
" Actually change the directory to the current file
command CDC cd %:p:h

" Fix gx for URLs
nmap <silent> gx yiW:!xdg-open <C-r>" & <CR><CR>
vmap <silent> gx y:!xdg-open <C-r>" & <CR><CR>

"toggle between absolute -> relative line number
" nnoremap <C-n> :let [&nu, &rnu] = [&nu, &nu+&rnu==1]<CR>
nnoremap <C-n> :set relativenumber! <CR>

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

" create horizontal window
nnoremap <c-w>h <c-w>s

" delete character after cursor in insert mode
" inoremap <C-l> <Del>

" Multi OS version (open for macOS)
" command -nargs=? DevDocs call system('type -p open >/dev/null 2>&1 && open https://devdocs.io/#q=<args> || xdg-open https://devdocs.io/#q=<args>')

" Only Linux
command! -nargs=? DevDocs call system('xdg-open https://devdocs.io/#q=<args>')
autocmd vimrc FileType python,ruby,rspec,javascript,go,html,php nnoremap <buffer><leader>D :execute "DevDocs " . expand('<cword>')<CR>

" arrow keys resize windows
nnoremap <left> :vertical resize -10<cr>
nnoremap <right> :vertical resize +10<cr>
nnoremap <up> :resize -10<cr>
nnoremap <down> :resize +10<cr>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Quit neovim terminal
tnoremap <C-q> <C-\><C-n>

" edit vimrc with f5 and source it with f6
nnoremap <silent> <leader><f5> :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader><f6> :source $MYVIMRC<CR>

" Simple Zoom / Restore window (like Tmux)
nnoremap <silent> <leader>z :call general#ZoomToggle()<CR>

" Execute a macro for the all selection
xnoremap @ :<C-u>call general#ExecuteMacroOverVisualRange()<CR>

" Disable anoying ex mode
nnoremap Q <Nop>

" Paste from the yank buffer
nnoremap <leader>p "0p
nnoremap <leader>P "0P

" Surround with s (I never use the NORMAL substitute command)
nmap s ys

" Save session
nnoremap <leader>ss :mksession! $VIMCONFIG/sessions/
" Reload session
nnoremap <leader>sl :source $VIMCONFIG/sessions/
" Source sets of macros
nnoremap <leader>ml :source $VIMCONFIG/macros/

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" +---------------+
" | User Commands |
" +---------------+

" buffer cleanup - delete every buffer except the one open
command! Ball :silent call general#Bdeleteonly()

" Add a journal entry
command! Jrnl call general#MakeJournalEntry()

" romainl redir (https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7)
command! -nargs=1 -complete=command -bar -range Redir silent call general#Redir(<q-args>, <range>, <line1>, <line2>)

" +---------+
" | autocmd |
" +---------+

" restore the position of the last cursor when you open a file
autocmd vimrc BufReadPost * call general#RestorePosition()

" delete trailing space when saving files
autocmd vimrc BufWrite *.php,*.js,*.jsx,*.vue,*.twig,*.html,*.sh,*.yaml,*.yml,*.clj,*.cljs,*.cljc,*.vim,*.lua call general#DeleteTrailingWS()

" Open files with external application
autocmd vimrc BufEnter *.png,*.jpg,*.gif silent! execute "! sxiv ".expand("%") | bwipeout
autocmd vimrc BufEnter *.pdf silent! execute "! zathura ".expand("%") "&" | bwipeout

" Toggle relative number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Formatting options (:help fo-table)
autocmd vimrc FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically source vimrc after saving
" autocmd vimrc bufwritepost init.vim source $MYVIMRC

" +--------------+
" | Highlighting |
" +--------------+

" highlight the line which is longer than the defined margin (80 character)
autocmd vimrc FileType php,js,vue,go,sh call matchadd('MaxLineChar', '\%80v', 100)
autocmd vimrc FileType vim call matchadd('MaxLineChar', '\%120v', 100)

" Highlight briefly yanked text
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300}

" +---------------+
" | Abbreviations |
" +---------------+

iabbrev IMO in my opinion
iabbrev BTW by the way
iabbrev <expr> cdate strftime('%Y-%m-%d')
iabbrev hte the

" Useful for writing the book Learning to Play Vim
iabbrev cur{} ж\cur{}ж

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
" set number

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

" Folds
" set foldlevelstart=999 " Start with all folds open
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

" to be able to use find in any projects
set path=.,**,,

" Don't display preview window for omni-completion
:set completeopt-=preview

" Set ripgrep for grep program
if executable('rg')
    set grepprg=rg\ --vimgrep
endif
