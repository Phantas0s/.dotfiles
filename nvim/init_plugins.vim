" Install Plugins ---------------------- {{{
" +----------------+
" | install plugin |
" +----------------+

call plug#begin("$VIMCONFIG/plugged")

" display the result when searching
Plug 'henrik/vim-indexed-search'

" general

Plug 'tpope/vim-surround' " surrounding text objects with paranthesis, quotes, html tags...
" Plug 'machakann/vim-sandwich' 
Plug 'tpope/vim-abolish' " easily search, substitute, abbreviate multiple version of words, coercion to camel case / snake case / dote case / title case...
Plug 'tpope/vim-repeat' " the . command can repeat whatever you want! See http://vimcasts.org/episodes/creating-repeatable-mappings-with-repeat-vim/
Plug 'tpope/vim-commentary' " keystroke to comment automatically

Plug 'wellle/targets.vim' " add new text object (can delete between comma with di, for example)
Plug 'machakann/vim-highlightedyank' " Highlight briefly every yanked text
Plug 'machakann/vim-swap' " swap arguments in parenthesis
Plug 'chaoren/vim-wordmotion' " camel case motion
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' " snippets
Plug 'itchyny/lightline.vim' " Status bar
" Plug 'svermeulen/vim-yoink' " Register history
" Plug 'bfredl/nvim-miniyank' " Register history
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

" debugger
Plug 'puremourning/vimspector'

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
Plug 'joonty/vdebug'
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'nishigori/vim-php-dictionary', {'for': 'php'}
Plug 'lumiliet/vim-twig', {'for': 'twig'} " twig
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'} " php refactoring options
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
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

" Databases
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

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
" Plug 'derekelkins/agda-vim'

call plug#end()
" }}}
