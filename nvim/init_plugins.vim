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
Plug 'tpope/vim-dispatch' " Asynchronous make

Plug 'AndrewRadev/splitjoin.vim' " Split or join arrays in PHP / struct in Go / other things
Plug 'andymass/vim-matchup' " Match more stuff with % (html tag, LaTeX...)
Plug 'editorconfig/editorconfig-vim'

" +----------+
" | Snippets |
" +----------+

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' " snippets

" +--------------------+
" | Reading doc in Vim |
" +--------------------+

Plug 'alx741/vinfo' " Open info documentation files

" +-----------+
" | Undo tree |
" +-----------+

Plug 'simnalamburt/vim-mundo' " Undo tree display

" +-----------+
" | Outliners |
" +-----------+

Plug 'liuchengxu/vista.vim' " Use LSP

" +------+
" | tmux |
" +------+

Plug 'tmux-plugins/vim-tmux' | Plug 'tmux-plugins/vim-tmux-focus-events' " syntax highlighting for tmux.conf + other cool options
Plug 'christoomey/vim-tmux-navigator' " seemless navigation between vim windows / tmux pane
Plug 'wellle/tmux-complete.vim' " Omni-completion from tmux pane

" +--------------------+
" | Project management |
" +--------------------+

Plug 'mhinz/vim-startify' " startify for startup cow

" +----------+
" | Debugger |
" +----------+

Plug 'puremourning/vimspector' "Multi language debugger

" +-----+
" | Git |
" +-----+

Plug 'tpope/vim-fugitive' "wrapper for git
Plug 'mhinz/vim-signify' "  display git diff in the left gutter
Plug 'rhysd/conflict-marker.vim' " Mark conflict

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

Plug 'neovim/nvim-lspconfig'

" +-----+
" | FZF |
" +-----+

Plug 'junegunn/fzf.vim'

" +---------+
" | Writing |
" +---------+

Plug 'godlygeek/tabular' " Align stuff (useful for markdown tables for example)
Plug 'rhysd/vim-grammarous', { 'for': 'markdown' } " Show grammar mistakes
Plug 'reedes/vim-wordy' " Verify quality of writting (see :Wordy)
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Preview markdown file in browser

" +-----+
" | PHP |
" +-----+

Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}

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

" +-----+
" | CSS |
" +-----+

Plug 'ap/vim-css-color' " Display the hexadecimal colors - useful for css and color config

" +-----+
" | CSV |
" +-----+

" Format CSV automatically
Plug 'chrisbra/csv.vim'

" +-----------+
" | VimScript |
" +-----------+

Plug 'tpope/vim-scriptease' " Debug vimscripts

call plug#end()
