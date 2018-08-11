" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
    set nocompatible
endif

" Declare the general config group for autocommand
augroup vimrc
  autocmd!
augroup END

"-----------------
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

" swap arguments in parenthesis
Plug 'machakann/vim-swap'

" add new text object (can delete between comma with di, for example)
Plug 'wellle/targets.vim'

" camel case motion
Plug 'chaoren/vim-wordmotion'

" Match more stuff with % (html tag, LaTeX...)
Plug 'tmhedberg/matchit'
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
Plug 'SidOfc/mkdx'
" Plug 'Ron89/thesaurus_query.vim' 

" nginx
Plug 'chr4/nginx.vim'

" Autocomplete system

" php autocompletion engine and tools
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'kristijanhusak/deoplete-phpactor',  {'for': 'php'}
" Plug 'zchee/deoplete-go', {'for': 'go'} " autocompletion
" Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx', 'vue'] }

Plug 'joonty/vdebug'

Plug 'roxma/ncm-phpactor',  {'for': 'php'}
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}

Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'stephpy/vim-php-cs-fixer', {'for': 'php'}
Plug 'nishigori/vim-php-dictionary', {'for': 'php'}

" php refactoring options
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug '2072/php-indenting-for-vim', {'for': 'php'}

" php doc autocompletion
Plug 'tobyS/vmustache' | Plug 'tobyS/pdv', {'for': 'php'}

" golang development
Plug 'fatih/vim-go', {'for': 'go'} " general plugin
Plug 'godoctor/godoctor.vim', {'for': 'go'} " refactoring
Plug 'sebdah/vim-delve', {'for': 'go'} " debugger
Plug 'buoto/gotests-vim', {'for': 'go'}


" twig
Plug 'lumiliet/vim-twig', {'for': 'twig'}

" javascript plugins
Plug 'pangloss/vim-javascript'
" need to run npm install in the folder ~/nvim/plugged/tern_for_vim
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx', 'vue'], 'do': 'npm install'}
" Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx', 'vue'] }

" For react
Plug 'mxw/vim-jsx'

" For Vue
Plug 'posva/vim-vue'

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

" systemd syntax and error
Plug 'wgwoods/vim-systemd-syntax'

" syntax for toml
Plug 'cespare/vim-toml'

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

" Table plugin
Plug 'dhruvasagar/vim-table-mode'

call plug#end()

"----------------
" plugin config
"----------------

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/*.nvimrc"), '\n')
    exe 'source' file
endfor

if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
set rtp+=~/nvim/godoctor.vim
filetype on
filetype plugin indent on

" Impossible to put it in vim-delve - to debug
let g:delve_breakpoint_sign = ""
let g:delve_tracepoint_sign = ""

" Autocompletion with tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" project config - is not on my git repository
source ~/nvim/projects.nvimrc

" close the buffer
nmap <leader>db :Bdelete!<cr>

" Twig
autocmd vimrc BufNewFile,BufRead *.twig set filetype=html.twig

" Yaml
autocmd vimrc BufNewFile,BufRead *.yml.dist set filetype=yaml.

"------------------
" general binding
"------------------
syntax on

" Weird hack for NERDTree to work
let mapleader = "\\"
map <SPACE> <leader>

" un-highlight when esc is pressed
map <silent><esc> :noh<cr>

" surround by quotes - frequently use cases of vim-surround
map <leader>" ysiw"<cr>
map <leader>' ysiw'<cr>

" Act like D and C
nnoremap Y y$

" indent without kill the selection in vmode
vmap < <gv
vmap > >gv

" remap the annoying u in visual mode
vmap u y

" shortcut to substitute current word under cursor
nnoremap <leader>[ :%s/<c-r><c-w>/<c-r><c-w>/g<left><left>

" Change in next bracket
nmap cinb cib

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call general#VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call general#VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" location & quickfix window
nnoremap <silent> <leader>l :call general#ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>q :call general#ToggleList("Quickfix List", 'c')<CR>

"Toggle between no numbers -> absolute -> relative line number
nnoremap <C-n> :let [&nu, &rnu] = [&nu, &nu+&rnu==1]<CR>

" tabs
nnoremap th :tabfirst<CR>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
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

" Quit neovim termial
tnoremap <C-\> <C-\><C-n>

" buffer cleanup - delete every buffer except the one open
command! Ball :silent call general#Bdeleteonly()

" restore the position of the last cursor when you open a file
autocmd vimrc BufReadPost * call general#RestorePosition()

" edit vimrc with f5 and source it with f6
nmap <silent> <leader><f5> :e $MYVIMRC<CR>
nmap <silent> <leader><f6> :so $MYVIMRC<CR>

" delete trailing space when saving files
autocmd vimrc BufWrite *.php,*.js,*.jsx,*.vue,*.twig,*.html,*.sh,*.yaml,*.yml :call general#DeleteTrailingWS()

" Simple Zoom / Restore window (like Tmux)
nnoremap <silent> <Leader>z :call general#ZoomToggle()<CR>

" Open images with feh
autocmd vimrc BufEnter *.png,*.jpg,*gif silent! exec "! feh ".expand("%") | :bw

" A |Dict| specifies the matcher for filtering and sorting the completion candidates.
let g:cm_matcher={'module': 'cm_matchers.abbrev_matcher', 'case': 'smartcase'}

" Execute a macro for the all selection
xnoremap @ :<C-u>call general#ExecuteMacroOverVisualRange()<CR>

"-----------------
" general config 
"-----------------

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

" Save session
exec 'nnoremap <Leader>ss :mksession! ~/nvim/sessions/*.vim<C-D><BS><BS><BS><BS><BS>'
" Reload session
exec 'nnoremap <Leader>sl :so ~/nvim/sessions/*.vim<C-D><BS><BS><BS><BS><BS>'

" when at 3 spaces, and I hit > ... go to 4, not 7
set shiftround

" number of undo saved in memory
set undolevels=10000 " How many undos
set undoreload=10000 " number of lines to save for undo

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
set scrolloff=999

" no swap file! This is just annoying
set noswapfile

" write automatically when quitting buffer
set autowrite

" Fold related
set foldlevelstart=0 " Start with all folds closed

" Set foldtext
set foldtext=general#FoldText()

" Show the substitution LIVE
set inccommand=nosplit

" Better ex autocompletion
set wildmenu
set wildmode=list:longest,full

" relative / hybrid line number switch
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" enable the mouse
" set mouse=a

" ncm debugging
" let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
" let $NVIM_NCM_LOG_LEVEL="DEBUG"
" let $NVIM_NCM_MULTI_THREAD=0
