" +----------------+
" | install plugin |
" +----------------+

call plug#begin("$VIMCONFIG/plugged")

" +---------+
" | General |
" +---------+

Plug 'tpope/vim-surround' " surrounding text objects with paranthesis, quotes, html tags...
Plug 'tpope/vim-abolish' " easily search, substitute, abbreviate multiple version of words, coercion to camel case / snake case / dote case / title case...
Plug 'tpope/vim-repeat' " the . command can repeat whatever you want! See http://vimcasts.org/episodes/creating-repeatable-mappings-with-repeat-vim/
Plug 'tpope/vim-commentary' " keystroke to comment automatically

Plug 'wellle/targets.vim' " add new text objects (can delete between comma with di, for example)
Plug 'henrik/vim-indexed-search' " display the result when searching
Plug 'machakann/vim-swap' " swap arguments in parenthesis
Plug 'itchyny/lightline.vim' " Status bar
Plug 'AndrewRadev/splitjoin.vim' " Split or join arrays in PHP / struct in Go / other things
Plug 'andymass/vim-matchup' " Match more stuff with % (html tag, LaTeX...)
" Plug 'chaoren/vim-wordmotion' " camel case motion
" Plug 'blueyed/vim-diminactive' " Plug to dim colors of not-focused windows
" Plug 'machakann/vim-highlightedyank' " Highlight briefly every yanked text (default in Neovim now)
Plug 'editorconfig/editorconfig-vim'

" +----------+
" | Snippets |
" +----------+

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' " snippets

" +--------------------+
" | Reading doc in Vim |
" +--------------------+

Plug 'jez/vim-superman' " Open man with vim using vman (need to be configured in zsh boot)
Plug 'alx741/vinfo' " Open info documentation files

" +-----------+
" | Undo tree |
" +-----------+

Plug 'simnalamburt/vim-mundo' " Undo tree display

" +-----------+
" | Outliners |
" +-----------+

" Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vista.vim' " Use LSP

" +------------+
" | Navigation |
" +------------+

Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']} | Plug 'tiagofumo/vim-nerdtree-syntax-highlight' | Plug 'ryanoasis/vim-devicons'
" Plug 'unblevable/quick-scope' " Highlight characters when using f F t T

" Plug 'simeji/winresizer' " Easy way to rezise and exchange windows
" Plug 'yangmillstheory/vim-snipe' " replace f F t T - don't work well with dot though :'(
" Plug 'kyazdani42/nvim-tree.lua'

" +------+
" | tmux |
" +------+

Plug 'tmux-plugins/vim-tmux' | Plug 'tmux-plugins/vim-tmux-focus-events' " syntax highlighting for tmux.conf + other cool options
Plug 'christoomey/vim-tmux-navigator' " seemless navigation between vim windows / tmux pane
Plug 'jpalardy/vim-slime' " Can send to tmux pane from Vim - cool for REPL

" +-------+
" | kitty |
" +-------+

" Plug 'knubie/vim-kitty-navigator', {'do': 'cp ./*.py ~/.config/kitty/'}

" +--------------------+
" | Project management |
" +--------------------+

Plug 'mhinz/vim-startify' " startify for startup cow

" +-------------------+
" | Compiler / Linter |
" +-------------------+

Plug 'neomake/neomake' " Maker & Linter

" +----------+
" | Debugger |
" +----------+

Plug 'puremourning/vimspector' "Multi language debugger

" +-----+
" | Git |
" +-----+

Plug 'tpope/vim-fugitive' "wrapper for git
Plug 'mhinz/vim-signify' "  display git diff in the left gutter
Plug 'junegunn/gv.vim' " Display commits for project / file
" Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-rhubarb'
" Plug 'rhysd/git-messenger.vim' " Display commit message for a precise line

" +---------------------+
" | Syntax highlighting |
" +---------------------+

Plug 'PotatoesMaster/i3-vim-syntax' " i3 config
Plug 'chr4/nginx.vim' " nginx
Plug 'wgwoods/vim-systemd-syntax' " systemd
Plug 'cespare/vim-toml' " toml

" +-----+
" | LSP |
" +-----+

" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'rafcamlet/coc-nvim-lua'
" Plug 'wellle/tmux-complete.vim' " Add tmux completion for COC
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-cmdline'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'andersevenrud/cmp-tmux'
Plug 'ojroques/nvim-lspfuzzy'

" +-----+
" | FZF |
" +-----+

Plug 'junegunn/fzf.vim'

" +---------+
" | Writing |
" +---------+

Plug 'godlygeek/tabular' " Align stuff (useful for markdown tables for example)
Plug 'christoomey/vim-titlecase' " Titlecase with gt
Plug 'rhysd/vim-grammarous', { 'for': 'markdown' } " Show grammar mistakes
Plug 'reedes/vim-wordy' " Verify quality of writting (see :Wordy)
Plug 'reedes/vim-lexical' " Dictionnary, thesaurus...
Plug 'ron89/thesaurus_query.vim' " Thesaurus
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Preview markdown file in browser
Plug 'lervag/vimtex' " latex

Plug 'junegunn/goyo.vim', { 'for': 'markdown' } " Distraction-free
Plug 'junegunn/limelight.vim', { 'for': 'markdown' } " Hyperfocus-writing

" +-----+
" | PHP |
" +-----+

" Plug 'StanAngeloff/php.vim', {'for': 'php'}
" Plug 'lumiliet/vim-twig', {'for': 'twig'} " twig
" Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'} " php refactoring options
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
Plug 'tobyS/vmustache' | Plug 'tobyS/pdv', {'for': 'php'} " php doc autocompletion
" Plug 'nishigori/vim-php-dictionary', {'for': 'php'}

" +------+
" | LISP |
" +------+

Plug 'guns/vim-sexp', { 'for': ['clojure', 'scheme'] }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': ['clojure', 'scheme'] }

" +---------+
" | Clojure |
" +---------+

Plug 'guns/vim-clojure-highlight', {'for': 'clojure'}
Plug 'guns/vim-clojure-static', {'for': 'clojure'}
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-dispatch', {'for': 'clojure'}

" +--------+
" | Golang |
" +--------+

Plug 'Phantas0s/go-analyzer.vim' " Custom plugin
" Plug 'sebdah/vim-delve', {'for': 'go'} " debugger
" Plug 'fatih/vim-go', {'for': 'go'} " general plugin
" Plug 'godoctor/godoctor.vim', {'for': 'go'} " refactoring

" +-----+
" | CSS |
" +-----+

Plug 'ap/vim-css-color' " Display the hexadecimal colors - useful for css and color config

" +-----+
" | CSV |
" +-----+

Plug 'chrisbra/csv.vim'

" +-----------+
" | VimScript |
" +-----------+

Plug 'tpope/vim-scriptease' " Debug vimscript

" Bad Practices - slow down everything, but good plugin idea
" Plug 'antonk52/bad-practices.nvim'
" Plug 'rcarriga/nvim-notify'

" Knowledge Management

call plug#end()
