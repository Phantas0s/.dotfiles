" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
    set nocompatible
endif

" Declare the general config group for autocommand
augroup vimrc
  autocmd!
augroup END

"----------------
" install plugin
"-----------------

call plug#begin('~/nvim/plugged')

" display the result when searching
Plug 'henrik/vim-indexed-search'

" syntax highlighting for tmux.conf + other cool options
Plug 'tmux-plugins/vim-tmux' | Plug 'tmux-plugins/vim-tmux-focus-events'
" seemless navigation between vim windows / tmux pane
Plug 'christoomey/vim-tmux-navigator'

" wrapper for git and display git diff in the left gutter
Plug 'tpope/vim-fugitive' | Plug 'mhinz/vim-signify' 
" Display commits for project / file
Plug 'junegunn/gv.vim'

" surrounding with whatever you want (paranthesis, quotes...)
Plug 'tpope/vim-surround'
" easily search, substitute and abbreviate multiple version of words
Plug 'tpope/vim-abolish'
" the . command can repeat whatever you want!
" http://vimcasts.org/episodes/creating-repeatable-mappings-with-repeat-vim/
Plug 'tpope/vim-repeat'
" comment automatically
Plug 'tpope/vim-commentary'

" Highlight briefly every yank text
Plug 'machakann/vim-highlightedyank'

" add new text object (can delete between comma with di, for example)
Plug 'wellle/targets.vim'

" camel case motion
Plug 'chaoren/vim-wordmotion'

" Match more stuff with % (html tag, LaTeX...)
Plug 'tmhedberg/matchit'

" Autocomplete system
Plug 'roxma/nvim-completion-manager'

" Swap two arguments in a function
Plug 'PeterRincker/vim-argumentative'

" vim project for one specific vimrc / project + startify for startup cow
Plug 'amiorin/vim-project'
Plug 'mhinz/vim-startify'

" general quality tools 
Plug 'neomake/neomake'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'gabrielelana/vim-markdown' " markdown plugin
Plug 'junegunn/goyo.vim', { 'for': 'markdown' } " Distraction-free
Plug 'junegunn/limelight.vim', { 'for': 'markdown' } " Hyperfocus-writing

" php autocompletion engine and tools
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'stephpy/vim-php-cs-fixer', {'for': 'php'}
Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
Plug 'nishigori/vim-php-dictionary', {'for': 'php'}

" php doc autocompletion
Plug 'tobyS/vmustache' | Plug 'tobyS/pdv', {'for': 'php'}

" go development
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'godoctor/godoctor.vim', {'for': 'go'}

" refactoring options
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'roxma/ncm-phpactor',  {'for': 'php'}
Plug '2072/php-indenting-for-vim', {'for': 'php'}

" twig
Plug 'lumiliet/vim-twig', {'for': 'twig'}

" javascript plugins
Plug 'pangloss/vim-javascript'
" need to run npm install in the folder ~/nvim/plugged/tern_for_vim
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx', 'vue'] }
" Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx', 'vue'] }

" Syntax highlighting for vue js framework
Plug 'posva/vim-vue'

" debugger
Plug 'joonty/vdebug'

" outliner
Plug 'majutsushi/tagbar'

" Nerdtree + modifications 
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" status bar
Plug 'itchyny/lightline.vim'

" undo tree
Plug 'sjl/gundo.vim'

" registers
Plug 'bfredl/nvim-miniyank'
" close the current buffer
Plug 'moll/vim-bbye'

" fzf - poweful fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" allow multisearch in current directory / multi replace as well
Plug 'wincent/ferret'

" display the hexadecimal colors - useful for css and color config
Plug 'ap/vim-css-color'

" easy way to rezise and exchange windows
Plug 'simeji/winresizer'

" replace f F t T to target easily the motion
Plug 'yangmillstheory/vim-snipe'

" Split arrays in PHP / struct in Go

Plug 'AndrewRadev/splitjoin.vim'

" Open man with vim using vman (need to be configured in zsh boot)
Plug 'jez/vim-superman'

" CSV plugin
Plug 'chrisbra/csv.vim'
call plug#end()

"----------------
" plugin config
"----------------

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/*.nvimrc"), '\n')
    exe 'source' file
endfor

" disable default mapping for vim-markdown
let g:markdown_enable_mappings = 0

" Autocompletion with tab
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" project config - is not on my git repository
source ~/nvim/projects.nvimrc

" close the buffer
nmap <leader>db :Bdelete!<cr>

" Startify config
let g:startify_list_order = ['bookmarks']

" Twig
autocmd vimrc BufNewFile,BufRead *.twig set filetype=html.twig


"------------------
" general binding
"------------------
if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
set rtp+=~/nvim/godoctor.vim
filetype plugin indent on
syntax on

" Weird hack for NERDTree to work
let mapleader = "\\"
map <SPACE> <leader>

" Go to next line and quit insert mode
nmap <leader>o o<esc>

" un-highlight when esc is pressed
map <esc> :noh<cr>

" surround by quotes - frequently use cases of vim-surround
map <leader>" ysiw"<cr>
map <leader>' ysiw'<cr>

" Act like D and C
nnoremap Y y$
nnoremap vv V
nnoremap V v$


" Enables you to save files with :w!! by using sudo if you forgot to open it as root
cmap w!! %!sudo tee > /dev/null %" display tabs, trailing spaces

" indent without kill the selection in vmode
vmap < <gv
vmap > >gv

" remap the annoying u in visual mode
vmap u y

" shortcut to substitute current word under cursor
nnoremap <leader>[ :%s/<c-r><c-w>/<c-r><c-w>/g<left><left>

" Change in next bracket
nmap cinb cib

" tabs
nnoremap th :tabfirst<CR>
nnoremap tj :tabnext<CR>
nnoremap tk :tabprev<CR>
nnoremap tl :tablast<CR>
nnoremap tn :tabnew<CR>

" windows navigation
nnoremap <leader>ww <c-w>w
nnoremap <leader>wh <c-w>h
nnoremap <leader>wj <c-w>j
nnoremap <leader>wk <c-w>k
nnoremap <leader>wl <c-w>l

" close all windows except the current one
nnoremap <leader>wco :only<cr>
nnoremap <leader>wcc :cclose<cr>

" windows creation
" create window on the bottom
nnoremap <leader>wb <c-w>s
" create vertival window
nnoremap <leader>wv <c-w>v

" delete character after cursor in insert mode
inoremap <C-d> <Del>

" highlight the line which is longer than the defined margin (120 character)
highlight ColorColumn ctermbg=red
autocmd vimrc FileType php,js,vue,go call matchadd('ColorColumn', '\%120v', 100)

" open devdocs.io with firefox and search the word under the cursor
command! -nargs=? DevDocs :call system('type -p open >/dev/null 2>&1 && open https://devdocs.io/#q=<args> || firefox -url https://devdocs.io/#q=<args>')
autocmd vimrc FileType python,ruby,rspec,javascript,go,html,php,eruby,coffee,haml nmap <buffer> <leader>D :exec "DevDocs " . fnameescape(expand('<cword>'))<CR>

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

" buffer cleanup - delete every buffer except the one open
command! Ball :silent call general#Bdeleteonly()

" restore the position of the last cursor when you open a file
autocmd vimrc BufReadPost * call general#RestorePosition()

" edit vimrc with f5 and source it automatically when saved
nmap <silent> <leader><f5> :e $MYVIMRC<CR>
autocmd vimrc BufWritePost $MYVIMRC nested source $MYVIMRC

" delete trailing space when saving files
autocmd vimrc BufWrite *.php,*.js,*.vue,*.twig,*.html,*.sh :call general#DeleteTrailingWS()

" Simple Zoom / Restore window (like Tmux)
nnoremap <silent> <Leader>z :call general#ZoomToggle()<CR>

" Open images with feh
autocmd vimrc BufEnter *.png,*.jpg,*gif silent! exec "! feh ".expand("%") | :bw

" A |Dict| specifies the matcher for filtering and sorting the completion candidates.
let g:cm_matcher={'module': 'cm_matchers.abbrev_matcher', 'case': 'smartcase'}

"-----------------
" general config 
"-----------------

" change cursor in nvim
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" colorscheme
colo hypnos

" set the directory where the swap file will be saved
set backupdir=~/nvim/backup//
set directory=~/nvim/swap//

" save undo trees in files
set undofile
set undodir=~/nvim/undo//

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
" when at 3 spaces, and I hit > ... go to 4, not 7
set shiftround


" number of undo saved in memory
set undolevels=10000

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" set list
set list listchars=tab:\┆\ ,trail:·,nbsp:±

" doesn't prompt a warning when opening a file and the current file was written but not saved 
set hidden

" doesn't display the mode status
set noshowmode

" Keep cursor more in middle when scrolling down / up
set scrolloff=15

" no swap file! This is just annoying
set noswapfile

" write automatically when quitting buffer
set autowrite

" Fold related
set foldlevelstart=0 " Start with all folds closed
" set foldcolumn=1 " Set fold column
"
" Set foldtext
set foldtext=general#FoldText()

" Show live the substitution
set inccommand=nosplit
