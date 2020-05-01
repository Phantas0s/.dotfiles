" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
    set nocompatible
endif

" Declare group for autocmd for whole init.vim, and clear it
" Otherwise every autocmd will be added to group each time vimrc sourced!
augroup vimrc
  autocmd!
augroup END

" Install Plugins ---------------------- {{{
" +----------------+
" | install plugin |
" +----------------+

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

" surrounding text objects with whatever you want (paranthesis, quotes, html tags...)
Plug 'tpope/vim-surround'

" easily search, substitute, abbreviate multiple version of words, coercion to camel case / snake case / dote case / title case...
Plug 'tpope/vim-abolish'

" the . command can repeat whatever you want!
" http://vimcasts.org/episodes/creating-repeatable-mappings-with-repeat-vim/
Plug 'tpope/vim-repeat'

" keystroke to comment automatically depending on the file you're in
Plug 'tpope/vim-commentary'

" Highlight briefly every yank text
Plug 'machakann/vim-highlightedyank'

" swap arguments in parenthesis
Plug 'machakann/vim-swap'

" add new text object (can delete between comma with di, for example)
Plug 'wellle/targets.vim'

" camel case motion
Plug 'chaoren/vim-wordmotion'

" Close the current buffer
Plug 'moll/vim-bbye'

" Match more stuff with % (html tag, LaTeX...)
Plug 'andymass/vim-matchup'

" vim project for one specific vimrc / project + startify for startup cow
Plug 'amiorin/vim-project' | Plug 'mhinz/vim-startify'

" Asynchronous linting for every languages
Plug 'neomake/neomake'

" snippets
Plug 'honza/vim-snippets'

" markdown / writting
Plug 'junegunn/goyo.vim', { 'for': 'markdown' } " Distraction-free
Plug 'junegunn/limelight.vim', { 'for': 'markdown' } " Hyperfocus-writing
Plug 'godlygeek/tabular' " Align plugin (useful for markdown tables for example)
Plug 'christoomey/vim-titlecase' " itlecase with gt
Plug 'rhysd/vim-grammarous', { 'for': 'markdown' } " show grammar mistakes
Plug 'reedes/vim-wordy' " Verify quality of writting (see :Wordy)
Plug 'reedes/vim-lexical' " Dictionnary, thesaurus...
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown'}

" colors for i3 config file
Plug 'PotatoesMaster/i3-vim-syntax'
" nginx syntax colors
Plug 'chr4/nginx.vim'
" systemd unit file syntax highlighting
Plug 'wgwoods/vim-systemd-syntax'
" toml syntax highlighting
Plug 'cespare/vim-toml'

" LSP
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install() }, 'branch': 'release'}, 

" fzf - poweful fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" PHP
" Plug 'joonty/vdebug'
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'stephpy/vim-php-cs-fixer', {'for': 'php'}
Plug 'nishigori/vim-php-dictionary', {'for': 'php'}
Plug 'lumiliet/vim-twig', {'for': 'twig'} " twig
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'} " php refactoring options
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug '2072/php-indenting-for-vim', {'for': 'php'}
Plug 'tobyS/vmustache' | Plug 'tobyS/pdv', {'for': 'php'} " php doc autocompletion 

" Clojure
Plug 'guns/vim-sexp', {'for': 'clojure'}
" Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
Plug 'guns/vim-clojure-highlight', {'for': 'clojure'}
Plug 'guns/vim-clojure-static', {'for': 'clojure'}
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-salve', {'for': 'clojure'}

" Add tmux completion for COC
" Plug 'wellle/tmux-complete.vim'

" Golang
Plug 'fatih/vim-go', {'for': 'go'} " general plugin
Plug 'godoctor/godoctor.vim', {'for': 'go'} " refactoring
Plug 'sebdah/vim-delve', {'for': 'go'} " debugger

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx' " For react
Plug 'posva/vim-vue' " For Vue

" Outliners
Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vista.vim' " Use LSP

" Nerdtree + modifications 
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']} | Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Status bar
Plug 'itchyny/lightline.vim'

" Undo tree display
Plug 'simnalamburt/vim-mundo'

" Register management
Plug 'bfredl/nvim-miniyank'
Plug 'junegunn/vim-peekaboo'

" Allow multisearch in current directory / multi replace as well
Plug 'wincent/ferret'

" Display the hexadecimal colors - useful for css and color config
Plug 'ap/vim-css-color'

" Easy way to rezise and exchange windows
Plug 'simeji/winresizer'

" replace f F t T - don't work well with dot though :'(
Plug 'yangmillstheory/vim-snipe'

" Split arrays in PHP / struct in Go / other things
Plug 'AndrewRadev/splitjoin.vim'

" Open man with vim using vman (need to be configured in zsh boot)
Plug 'jez/vim-superman'

" CSV plugin
Plug 'chrisbra/csv.vim'

" Plug to dim colors of not-focused windows
Plug 'blueyed/vim-diminactive'

" Write file with sudo
Plug 'lambdalisue/suda.vim'

Plug 'ActivityWatch/aw-watcher-vim'

Plug 'tpope/vim-scriptease'

Plug '~/nvim/plugged/potion'

call plug#end()
" }}}
" Plugin Config ---------------------- {{{

" +---------------+
" | plugin config |
" +---------------+

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/*.nvimrc"), '\n')
    execute 'source' file
endfor

if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
set rtp+=~/nvim/godoctor.vim
filetype on
filetype plugin indent on

" Impossible to put it in vim-delve.nvimrc file...
let g:delve_breakpoint_sign = ""
let g:delve_tracepoint_sign = ""

" project config - personnal file (not on my git repository)
source ~/nvim/projects.nvimrc

" close the buffer
nnoremap <leader>db :Bdelete!<cr>

" Coc extensions
let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-json', 
    \ 'coc-css', 
    \ 'coc-tsserver',
    \ 'coc-html',
    \ 'coc-yaml',
    \]
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

" to create boxes!!
vmap <F2> !boxes -d stone

" un-highlight when esc is pressed
map <silent><esc> :noh<cr>

" surround by quotes - frequently use cases of vim-surround
" Act like D and C
nnoremap Y y$

" indent without kill the selection in vmode
vmap < <gv
vmap > >gv

" remap the annoying u in visual mode
vmap u y

" visual mode pressing * or # searches for the current selection
" super useful! from an idea by michael naumann
vnoremap <silent> * :<C-u>call general#VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call general#VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" search with very magic mode on
nnoremap <leader>/ /\v

" location & quickfix window
nnoremap <silent> <leader>l :call general#ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>q :call general#ToggleList("Quickfix List", 'c')<CR>

"toggle between absolute -> relative line number
nnoremap <C-n> :let [&nu, &rnu] = [&nu, &nu+&rnu==1]<CR>

" tabs
nnoremap th :tabfirst<CR>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap tl :tablast<CR>
nnoremap tn :tabnew<CR>

" move tab to first position
nnoremap tF :tabm 0<CR>
nnoremap tL :tabm<CR>

" windows navigation
" use ctrl + hjkl

" close all windows except the current one
nnoremap <leader>wco :only<cr>
nnoremap <leader>wcc :cclose<cr>

" windows creation
" create horizontal window
nnoremap <leader>wh <c-w>s
" create vertival window
nnoremap <leader>wv <c-w>v

" delete character after cursor in insert mode
inoremap <C-d> <Del>

" highlight the line which is longer than the defined margin (120 character)
highlight MaxLineChar ctermbg=red
autocmd vimrc FileType php,js,vue,go call matchadd('MaxLineChar', '\%120v', 100)

" open devdocs.io with firefox and search the word under the cursor
command! -nargs=? DevDocs :call system('type -p open >/dev/null 2>&1 && open https://devdocs.io/#q=<args> || firefox -url https://devdocs.io/#q=<args>')
autocmd vimrc FileType python,ruby,rspec,javascript,go,html,php,eruby,coffee,haml nnoremap <buffer><leader>D :execute "DevDocs " . fnameescape(expand('<cword>'))<CR>
" same but with clojuredocs
command! -nargs=? ClojureDoc :call system('type -p open >/dev/null 2>&1 && open https://clojuredocs.org/search\?q=<args> || firefox -url https://clojuredocs.org/search\?q=<args>')
autocmd vimrc FileType clojure nnoremap <buffer><leader>D :execute "ClojureDoc " . fnameescape(expand('<cword>'))<CR>

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

" restore the position of the last cursor when you open a file
autocmd vimrc BufReadPost * call general#RestorePosition()

" edit vimrc with f5 and source it with f6
nnoremap <silent> <leader><f5> :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader><f6> :source $MYVIMRC<CR>

" delete trailing space when saving files
autocmd vimrc BufWrite *.php,*.js,*.jsx,*.vue,*.twig,*.html,*.sh,*.yaml,*.yml,*.clj,*.cljs,*.cljc :call general#DeleteTrailingWS()

" Simple Zoom / Restore window (like Tmux)
nnoremap <silent><leader>z :call general#ZoomToggle()<CR>

" Open images with feh
autocmd vimrc BufEnter *.png,*.jpg,*gif silent! execute "! feh ".expand("%") | :bw

" Execute a macro for the all selection
xnoremap @ :<C-u>call general#ExecuteMacroOverVisualRange()<CR>

" Disable anoying ex mode
nnoremap Q <Nop>

" Save files as root
cnoremap w!! execute ':w suda://%'
" }}}
" Set options ---------------------- {{{

" +--------------+
" | Set  options |
" +--------------+

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
nnoremap <leader>ss :mksession! ~/nvim/sessions/*.vim<C-D><BS><BS><BS><BS><BS>
" Reload session
nnoremap <leader>sl :so ~/nvim/sessions/*.vim<C-D><BS><BS><BS><BS><BS>

" when at 3 spaces, and I hit > ... indent of 4 spaces in total, not 7
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

" avoid delay
set updatetime=300

" always show signcolumns
set signcolumn=yes

" don't give |ins-completion-menu| messages.
set shortmess+=c

" doesn't display the mode status
set noshowmode

" Keep cursor more in middle when scrolling down / up
set scrolloff=999

" no swap file! This is just annoying
set noswapfile

" write automatically when quitting buffer
set autowrite

" Fold related
" set foldlevelstart=0 " Start with all folds closed

" Set foldtext
" set foldtext=general#FoldText()

" Show the substitution LIVE
set inccommand=nosplit

" Better ex autocompletion
set wildmenu
set wildmode=list:longest,full

" relative / hybrid line number switch
set number relativenumber

" for vertical pane in git diff tool
set diffopt+=vertical

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

autocmd vimrc FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" }}}
