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
lua require('hypnos/text_objects').indent_text_objects()

" source every plugin configs
for file in split(glob('$VIMCONFIG/pluggedconf/*.nvimrc'), '\n')
    execute 'source' file
endfor

" +------------------+
" | global variables |
" +------------------+

" Disable fold in markdown
let g:vim_markdown_folding_disabled = 1

" New and fast way for detecting filetype
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

" Lua syntax highlighting in Vimscript (*.vim) files
let g:vimsyn_embed = 'l;'

let g:markdown_fenced_languages = ['html', 'python', 'lua', 'vim', 'typescript', 'javascript']

" +-----------------+
" | general mapping |
" +-----------------+

" Create box and figlet - ESSENTIAL :D
vmap <F2> !boxes -d stone<cr>
vmap <f3> !figlet<cr>

" un-highlight when esc is pressed
nnoremap <silent> <c-c> <Cmd>nohlsearch<cr>

" indent without killing the selection in VISUAL mode
" vmap < <gv
" vmap > >gv

inoremap <C-d> <Del>

" location & quickfix
nnoremap <silent> <leader>l :call general#ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>q :call general#ToggleList("Quickfix List", 'c')<CR>
nnoremap <leader>j :cnext<CR>
nnoremap <leader>k :cprevious<CR>
nnoremap <leader>lj :lnext<CR>
nnoremap <leader>lk :lprevious<CR>

" close the current buffer and switch to alternate buffer
nnoremap <silent> <leader>dd <cmd>bp <bar>bd! #<cr>

" open relative paths under cursor with xdg-open (example: './my/relative/file.pdf')
nnoremap <silent> gX :execute "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>

" open current file using xdg-open
nnoremap <leader>x :silent :execute "!xdg-open %"<CR>

" Go to file even if doesn't exist
nnoremap gF :e <cfile><CR>

" Actually change the directory to the current file
command CDC cd %:p:h

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

nnoremap <leader>g :file<cr>

" +---------------+
" | User Commands |
" +---------------+

" buffer cleanup - delete every buffer except the one open
command! Ball :silent call general#Bdeleteonly()

" Add a journal entry
command! Jrnl call general#MakeJournalEntry()

" romainl redir (https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7)
command! -nargs=1 -complete=command -bar -range Redir silent call general#Redir(<q-args>, <range>, <line1>, <line2>)

command! -nargs=1 -complete=command LimitChar silent call matchadd('MaxLineChar', '\%' . <q-args> . 'v')

" +---------+
" | autocmd |
" +---------+

" restore the position of the last cursor when you open a file
autocmd vimrc BufReadPost * call general#RestorePosition()

" delete trailing space when saving files
autocmd vimrc BufWrite *.php,*.js,*.jsx,*.vue,*.twig,*.html,*.sh,*.yaml,*.yml,*.clj,*.cljs,*.cljc,*.vim,*.lua,*.md call general#DeleteTrailingWS()

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
autocmd vimrc FileType php,js,vue,go,sh,md call matchadd('MaxLineChar', '\%80v', 10)
autocmd vimrc FileType vim call matchadd('MaxLineChar', '\%120v', 100)

" Highlight briefly yanked text
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300}

" +---------------+
" | Abbreviations |
" +---------------+

" Some abbreviations finish with _ because it's not often that an underscore is followed by a space

" from `:help abbreviations`
func Delchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

iabbrev IMO in my opinion
iabbrev BTW by the way

" Typos
iabbrev hte the
iabbrev teh the
iabbrev authros authors
iabbrev authro author
iabbrev proejct project
iabbrev direcotry directory
iabbrev direcotries directories
iabbrev trhe the
iabbrev insteand instead
iabbrev solutiosn solutions
iabbrev documenation documentation
iabbrev itslef itself
iabbrev hisotry history
iabbrev frist first

" Date
iabbrev <expr> date_ strftime('%Y-%m-%d')

" Useful for writing the book Learning to Play Vim
iabbrev cur_ ж\cur{}ж<left><left><c-r>=Delchar('\s')<cr>
iabbrev mne_ []{.mne}<Esc>F[a<c-r>=Delchar('\s')<cr>
iabbrev sc_ []{.smallcaps}<Esc>F[a<c-r>=Delchar('\s')<cr>

" +-------+
" | netrw |
" +-------+

command! Oexplore exe 'Vexplore' getcwd()

" Open on the left
nnoremap <leader>v :Vexplore<cr>
nnoremap <leader>V :Oexplore<cr>

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
    set grepprg=rg\ --vimgrep\ --smart-case
endif
