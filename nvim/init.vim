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

call plug#begin("$VIMCONFIG/plugged")

" display the result when searching
Plug 'henrik/vim-indexed-search'

" general

" Plug 'tpope/vim-surround' " surrounding text objects with paranthesis, quotes, html tags...
Plug 'machakann/vim-sandwich' 
Plug 'tpope/vim-abolish' " easily search, substitute, abbreviate multiple version of words, coercion to camel case / snake case / dote case / title case...
Plug 'tpope/vim-repeat' " the . command can repeat whatever you want! See http://vimcasts.org/episodes/creating-repeatable-mappings-with-repeat-vim/
Plug 'tpope/vim-commentary' " keystroke to comment automatically

Plug 'wellle/targets.vim' " add new text object (can delete between comma with di, for example)
Plug 'machakann/vim-highlightedyank' " Highlight briefly every yanked text
Plug 'machakann/vim-swap' " swap arguments in parenthesis
Plug 'chaoren/vim-wordmotion' " camel case motion
Plug 'honza/vim-snippets' " snippets
Plug 'itchyny/lightline.vim' " Status bar
" Plug 'svermeulen/vim-yoink' " Register history
Plug 'bfredl/nvim-miniyank' " Register history
Plug 'stefandtw/quickfix-reflector.vim' " Allow multisearch in current directory / multi replace as well
Plug 'lambdalisue/suda.vim' " Write file with sudo
Plug 'blueyed/vim-diminactive' " Plug to dim colors of not-focused windows
Plug 'ap/vim-css-color' " Display the hexadecimal colors - useful for css and color config
Plug 'jez/vim-superman' " Open man with vim using vman (need to be configured in zsh boot)
Plug 'alx741/vinfo' " Open info documentation files
Plug 'AndrewRadev/splitjoin.vim' " Split arrays in PHP / struct in Go / other things
" Plug 'lpinilla/vim-codepainter'

" undo tree
Plug 'simnalamburt/vim-mundo' " Undo tree display

" outliners
Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vista.vim' " Use LSP

" navigation
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']} | Plug 'tiagofumo/vim-nerdtree-syntax-highlight' | Plug 'ryanoasis/vim-devicons'
" Plug 'vifm/vifm.vim'
" Plug 'moll/vim-bbye' " Close the current buffer
Plug 'simeji/winresizer' " Easy way to rezise and exchange windows
" replace f F t T - don't work well with dot though :'(
Plug 'yangmillstheory/vim-snipe'
Plug 'andymass/vim-matchup' " Match more stuff with % (html tag, LaTeX...)

" tmux
Plug 'tmux-plugins/vim-tmux' | Plug 'tmux-plugins/vim-tmux-focus-events' " syntax highlighting for tmux.conf + other cool options
Plug 'christoomey/vim-tmux-navigator' " seemless navigation between vim windows / tmux pane
Plug 'jpalardy/vim-slime'

" project management
Plug 'amiorin/vim-project' | Plug 'mhinz/vim-startify' " vim project for one specific vimrc / project + startify for startup cow

" compiler
Plug 'neomake/neomake'

" git
Plug 'tpope/vim-fugitive' | Plug 'mhinz/vim-signify' " wrapper for git and display git diff in the left gutter
Plug 'junegunn/gv.vim' " Display commits for project / file
Plug 'rhysd/git-messenger.vim' " Display commit message for a precise line

" syntax highlighting
Plug 'PotatoesMaster/i3-vim-syntax' " i3 config
Plug 'chr4/nginx.vim' " nginx 
Plug 'wgwoods/vim-systemd-syntax' " systemd 
Plug 'cespare/vim-toml' " toml 

" lsp
" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install() }, 'branch': 'release'}, 
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'wellle/tmux-complete.vim' " Add tmux completion for COC

" fzf
Plug 'junegunn/fzf.vim'

" markdown / writting
Plug 'junegunn/goyo.vim', { 'for': 'markdown' } " Distraction-free
Plug 'junegunn/limelight.vim', { 'for': 'markdown' } " Hyperfocus-writing
Plug 'godlygeek/tabular' " Align plugin (useful for markdown tables for example)
Plug 'christoomey/vim-titlecase' " Titlecase with gt
Plug 'rhysd/vim-grammarous', { 'for': 'markdown' } " show grammar mistakes
Plug 'reedes/vim-wordy' " Verify quality of writting (see :Wordy)
Plug 'reedes/vim-lexical' " Dictionnary, thesaurus...
Plug 'ron89/thesaurus_query.vim' " Thesaurus
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" PHP
" Plug 'joonty/vdebug'
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'stephpy/vim-php-cs-fixer', {'for': 'php'}
Plug 'nishigori/vim-php-dictionary', {'for': 'php'}
Plug 'lumiliet/vim-twig', {'for': 'twig'} " twig
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'} " php refactoring options
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
Plug '2072/php-indenting-for-vim', {'for': 'php'}
Plug 'tobyS/vmustache' | Plug 'tobyS/pdv', {'for': 'php'} " php doc autocompletion 

" LISP
Plug 'guns/vim-sexp', { 'for': ['clojure', 'scheme'] }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': ['clojure', 'scheme'] }

" Clojure
Plug 'guns/vim-clojure-highlight', {'for': 'clojure'}
Plug 'guns/vim-clojure-static', {'for': 'clojure'}
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
" Plug 'tpope/vim-salve', {'for': 'clojure'}
Plug 'tpope/vim-dispatch', {'for': 'clojure'}

" Golang
Plug 'fatih/vim-go', {'for': 'go'} " general plugin
Plug 'godoctor/godoctor.vim', {'for': 'go'} " refactoring
Plug 'sebdah/vim-delve', {'for': 'go'} " debugger
Plug 'Phantas0s/go-analyzer.vim' " Custom plugin 
" Plug '$XDG_CONFIG_HOME/workspace/vim-plugins/go-analyzer.vim'

" Javascript
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
" Plug 'mxw/vim-jsx' " For react
" Plug 'posva/vim-vue' " For Vue

" GDScript (Godot Game Engine)
" Plug 'calviken/vim-gdscript3'

" CSV 
Plug 'chrisbra/csv.vim'

" VimScript
Plug 'tpope/vim-scriptease' " Debug vimscript

" Agda
Plug 'derekelkins/agda-vim'

call plug#end()
" }}}
" Plugin Config ---------------------- {{{

" +---------------+
" | plugin config |
" +---------------+

let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
" let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}

" source every plugin configs
for file in split(glob("$VIMCONFIG/pluggedconf/*.nvimrc"), '\n')
    execute 'source' file
endfor

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
    \ 'coc-snippets',
    \ 'coc-css', 
    \ 'coc-html',
    \ 'coc-json', 
    \ 'coc-yaml', 
    \ 'coc-godot', 
    \ 'coc-pyright',
    \ 'coc-phpactor',
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

" Stop undo at each space
inoremap <space> <C-G>u<space>

" to create boxes!!
vmap <F2> !boxes -d stone

" to create ascii art!!
vmap <f3> !figlet<CR>

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

" contents of any register are inserted literally (prevent clipboard hacking)
" inoremap <C-r> <C-r><C-o>

" Create tags for help text
nnoremap <leader>H execute "helptags" expand("%:h")

" search with very magic mode on
nnoremap <leader>/ /\v
" search with no magic
nnoremap <leader>? /\M

" location & quickfix window
nnoremap <silent> <leader>l :call general#ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>q :call general#ToggleList("Quickfix List", 'c')<CR>

" open relative paths under cursor with xdg-open (example: './my/relative/file.pdf')
nnoremap gX :silent :execute
            \ "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>

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

" create horizontal window
nnoremap <c-w>h <c-w>s

" delete character after cursor in insert mode
inoremap <C-l> <Del>

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
command! Jrnl call general#MakeJournalEntry()

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

" Save session
nnoremap <leader>ss :mksession! $VIMCONFIG/sessions/
" Reload session
nnoremap <leader>sl :so $VIMCONFIG/sessions/

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
set updatetime=300

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

" augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END

" autocmd vimrc FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" if executable('rg')
"     set grepprg=rg\ --vimgrep
" endif

" }}}

