if !1 | finish | endif

" Declare group for autocmd for whole init.vim, and clear it
" Otherwise every autocmd will be added to group each time vimrc sourced!
augroup vimrc
    autocmd!
augroup END

" +------------+
" | leader key |
" +------------+ {{{

" Configure leader key
let mapleader = "\<space>"
let maplocalleader = "\<space>"

" }}}

" +----------------+
" | install plugin |
" +----------------+ {{{

" Source plugin definition file
source $VIMCONFIG/init_plugins.vim

" Load custom library for lua
lua require('hypnos/kit')

" Load all Lua stuff
lua require('hypnos/status_line')
lua require('hypnos/tab_line')
lua require('hypnos/text_objects').basic_text_objects()
lua require('hypnos/text_objects').indent_text_objects()
lua require('hypnos/project').read_project_config()

" source every plugin configs
for file in split(glob('$VIMCONFIG/pluggedconf/*.nvimrc'), '\n')
    execute 'source' file
endfor

" }}}

" +------------------+
" | global variables |
" +------------------+ {{{

" Disable fold in markdown
let g:vim_markdown_folding_disabled = 1

" New and fast way for detecting filetype
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

" Lua syntax highlighting in Vimscript (*.vim) files
let g:vimsyn_embed = 'l'

" Add highlighting for the following languages in markdown
let g:markdown_fenced_languages = ['html', 'python', 'lua', 'vim', 'typescript', 'javascript', 'go', 'yaml']

" }}}

" +-----------------+
" | general mapping |
" +-----------------+ {{{

" Create box and figlet - ESSENTIAL :D
vmap <F2> !boxes -d stone<cr>
vmap <f3> !figlet<cr>

" un-highlight the last search result
nnoremap <silent> <leader><space> <Cmd>nohlsearch<cr>
inoremap <c-d> <del>

" location & quickfix
nnoremap <leader>j :cnext<cr>
nnoremap <leader>k :cprevious<cr>
nnoremap <leader>lj :lnext<cr>
nnoremap <leader>lk :lprevious<cr>

" close the current buffer and switch to alternate buffer
nnoremap <silent> <leader>dd <cmd>bp <bar> bd! #<cr>

" open relative paths under cursor with xdg-open (example: './my/relative/file.pdf')
nnoremap <silent> gX :silent :execute "!xdg-open" expand('%:p:h') . "/" . expand("<cfile>") " &"<cr>

" open current file using xdg-open
nnoremap <leader>x :silent :execute "!xdg-open %"<cr>

" Go to file even if doesn't exist
nnoremap gF :e <cfile><cr>

"toggle between absolute -> relative line number
" nnoremap <C-n> :let [&number, &relativenumber] = [&number, &number+&relativenumber==1]<cr>
nnoremap <c-n> <cmd>set relativenumber!<cr>
inoremap <c-n> <cmd>set relativenumber!<cr>

" tabs
nnoremap th :tabfirst<cr>
nnoremap tk :tabnext<cr>
nnoremap tj :tabprev<cr>
nnoremap tl :tablast<cr>
nnoremap tn :tabnew<cr>
nnoremap tc :tabclose<cr>

" move tab to first position
nnoremap tH :tabm 0<cr>
nnoremap tL :tabm<cr>

" create horizontal window
nnoremap <c-w>h <c-w>s

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
nnoremap <silent> <leader><f5> :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader><f6> :source $MYVIMRC<cr>

" Execute a macro for the all selection
xnoremap @ <cmd>call general#ExecuteMacroOverVisualRange()<cr>

xnoremap s :s/\%V//g<left><left><left>

" Paste from the yank buffer
" nnoremap <leader>p "0p
" nnoremap <leader>P "0P

" Surround with s (I never use the substitute command in normal mode)
nmap s ys

" Save session
nnoremap <leader>ss :mksession! $VIMCONFIG/sessions/
" Reload session (here `<C-Z> trigger the completin - see wildcharm`)
nnoremap <leader>sl :source $VIMCONFIG/sessions/<c-z>
" Source sets of macros
nnoremap <leader>ml :source $VIMCONFIG/macros/

inoremap <expr> <c-j> pumvisible() ? '<c-n>' : '<c-j>'
inoremap <expr> <c-k> pumvisible() ? '<c-p>' : '<c-k>'

cnoremap <expr> <c-j> pumvisible() ? '<c-n>' : '<c-j>'
cnoremap <expr> <c-k> pumvisible() ? '<c-p>' : '<c-k>'

nnoremap <silent> <leader>p :let &path=join(split(system("find $(pwd) -type d -not -path '*git*'"), '\n'), ',')<cr>

" Automatically fix the spelling
imap <c-z> <c-g>u<Esc>[s1z=`]a<c-g>u
nnoremap <silent> <leader>Z 1z=

" Simple Zoom / Restore window (like Tmux)
nnoremap <silent> <leader>z :call general#ZoomToggle()<cr>

" Scroll more
nnoremap <c-e> 10<c-e>
nnoremap <c-y> 10<c-y>

" Jumping from branch to branch in the undo tree
nnoremap <leader>u g-
nnoremap <leader>r g+

" Open all folds more easily
nnoremap zz zR

" Define a text-object for square brackets
onoremap ir i[
onoremap ar a[

" }}}

" +---------------+
" | user commands |
" +---------------+ {{{

" buffer cleanup - delete every buffer except the one open
command! Ball :silent call general#Bdeleteonly()

" Add a journal entry
command! Jrnl call general#MakeJournalEntry()

" romainl redir (https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7)
command! -nargs=1 -complete=command -bar -range Redir call general#Redir(<q-args>, <range>, <line1>, <line2>)

command! -nargs=1 -complete=command LimitChar silent call matchadd('MaxLineChar', '\%' . <q-args> . 'v')

" Change the directory to the current file
command! CDC cd %:p:h

" Try to use popup in Neovim
command! Gpopupblame call general#GitBlame()
command! CloseFloat call general#CloseFloat()

" }}}

" +---------+
" | autocmd |
" +---------+ {{{

autocmd vimrc CmdlineEnter \?,/ set hlsearch
autocmd vimrc InsertEnter * set nohlsearch

" restore the position of the last cursor when you open a file
autocmd vimrc BufReadPost * call general#RestorePosition()

" delete trailing space when saving files
autocmd vimrc BufWrite *.php,*.js,*.jsx,*.vue,*.twig,*.html,*.sh,*.yaml,*.yml,*.clj,*.cljs,*.cljc,*.vim,*.lua,*.md call general#DeleteTrailingWS()

" Open files with external application
autocmd vimrc BufEnter *.png,*.jpg,*.gif silent! execute "!sxiv ".expand("%") | bwipeout
autocmd vimrc BufEnter *.pdf silent! execute "!zathura ".expand("%") "&" | bwipeout

" Toggle relative number
" augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END

" Formatting options (:help fo-table)
autocmd vimrc FileType vim,lua setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Multi OS version (open for macOS)
" command -nargs=? DevDocs call system('type -p open >/dev/null 2>&1 && open https://devdocs.io/#q=<args> || xdg-open https://devdocs.io/#q=<args>')
" Only Linux
command! -nargs=? DevDocs call system('xdg-open https://devdocs.io/#q=<args>')
autocmd vimrc FileType python,ruby,rspec,javascript,go,html,php nnoremap <buffer><leader>D :execute "DevDocs " . expand('<cword>')<cr>

" Automatically source vimrc after saving
autocmd vimrc BufWritePost init.vim source $MYVIMRC

" }}}

" +--------------+
" | highlighting |
" +--------------+ {{{

" highlight the line which is longer than the defined margin (80 character)
autocmd vimrc FileType php,js,vue,go,sh,md call matchadd('MaxLineChar', '\%80v', 10)
autocmd vimrc FileType vim call matchadd('MaxLineChar', '\%120v', 100)
autocmd vimrc FileType gitcommit call matchadd('MaxLineChar', '\%72v', 100)

" Highlight briefly yanked text
autocmd vimrc TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300}

" }}}

" +---------------+
" | abbreviations |
" +---------------+ {{{

" from `:help abbreviations` (see `:helpgrep Eatchar`)
func! Delchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

iabbrev IMO in my opinion
iabbrev IMHO in my humble opinion
iabbrev BTW by the way

" Typos
iabbrev hte the
iabbrev teh the
iabbrev thme them
iabbrev htey they
iabbrev iwth with
iabbrev htat that
iabbrev hlep help
iabbrev myabe maybe
iabbrev exmaple example
iabbrev exmaples examples
iabbrev followign following
iabbrev wihtout without
iabbrev authros authors
iabbrev authro author
iabbrev proejct project
iabbrev varialbe variable
iabbrev direcotry directory
iabbrev direcotries directories
iabbrev environemnt environment
iabbrev trhe the
iabbrev insteand instead
iabbrev solutiosn solutions
iabbrev documenation documentation
iabbrev itslef itself
iabbrev hisotry history
iabbrev frist first
iabbrev functioanlities functionalities
iabbrev functioantlities functionalities
iabbrev opearte operate
iabbrev infomration information
iabbrev wnat want
iabbrev soltuion solution
iabbrev almsot almost
iabbrev chnaging changing
iabbrev mutliple multiple
iabbrev intersting interesting
iabbrev inofmration information
iabbrev sovling solving
iabbrev fisrt first
iabbrev benefitial beneficial
iabbrev comamnd command
iabbrev thsi this
iabbrev occurence occurrence
iabbrev specfic specific
iabbrev positoin position
iabbrev taht that
iabbrev anme name
iabbrev tehn then
iabbrev thansk thanks
iabbrev waht what

" Date
iabbrev <expr> date_ strftime('%Y-%m-%d')

" }}}

" +-------+
" | netrw |
" +-------+ {{{

command! Oexplore exe 'Explore' getcwd()

" Open on the left
nnoremap <leader>v :Explore<cr>
nnoremap <leader>V :Oexplore<cr>

" }}}

" +---------+
" | options |
" +---------+ {{{

" colorscheme
colorscheme hypnos

" 256 colors
set notermguicolors

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

" the copy goes to the clipboard
set clipboard+=unnamedplus

" use 4 spaces instead of tab (to replace existing tab use :retab)
" copy indent from current line when starting a new line
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set autoindent

" when at 3 spaces, and I hit > ... indent of 4 spaces in total, not 7
set shiftround

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" set list
" set list listchars=tab:\┆\ ,trail:·,nbsp:±
set list
let &listchars='tab:┆ ,trail:·'

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

" relative / hybrid line number switch
set number relativenumber

" for vertical pane in git diff tool
set diffopt+=vertical

" to be able to use find in any projects
" set path=.,**,,
let &path=join(split(system('fd . --type d'), '\n'), ',')

" Don't display preview window for omni-completion
set completeopt-=preview

" Mapping to trigger completion in macro and mappings
set wildcharm=<c-z>

" Split window when jump to a position from quickfix list
" set switchbuf=vsplit

" Set ripgrep for grep program
if executable('rg')
    let &grepprg='rg --vimgrep --smart-case $*'
endif

" }}}
