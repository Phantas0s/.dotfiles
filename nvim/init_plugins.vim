" +----------------+
" | install plugin |
" +----------------+

packadd cfilter

command! -nargs=1 PlugSource execute 'packadd!' split(<q-args>, '/')[1]

" +---------+
" | General |
" +---------+

" Format CSV automatically
packadd! csv.vim

PlugSource tpope/vim-surround " surrounding text objects with paranthesis, quotes, html tags...
packadd! vim-abolish " easily search, substitute, abbreviate multiple version of words, coercion to camel case / snake case / dote case / title case...
packadd! vim-repeat " the . command can repeat whatever you want! See http://vimcasts.org/episodes/creating-repeatable-mappings-with-repeat-vim/
packadd! vim-commentary " keystroke to comment automatically
packadd! vim-dispatch " Asynchronous make

packadd! splitjoin.vim " Split or join arrays in PHP / struct in Go / other things

packadd! diffview.nvim " Diffs


" +----------+
" | Snippets |
" +----------+

packadd! ultisnips
packadd! vim-snippets

" +--------------------+
" | Reading doc in Vim |
" +--------------------+

packadd! vinfo

" +-----------+
" | Outliners |
" +-----------+

packadd! vista.vim " Use LSP

" +------+
" | tmux |
" +------+

packadd! vim-tmux
packadd! vim-tmux-focus-events " syntax highlighting for tmux.conf + other cool options
packadd! vim-tmux-navigator " seemless navigation between vim windows / tmux pane

" +--------------------+
" | Project management |
" +--------------------+

packadd! vim-startify " startify for startup cow

" +----------+
" | Debugger |
" +----------+

" Plug 'puremourning/vimspector' "Multi language debugger

" +-----+
" | Git |
" +-----+

packadd! vim-fugitive "wrapper for git
packadd! vim-signify "  display git diff in the left gutter

" +---------------------+
" | Syntax highlighting |
" +---------------------+

" Plug 'mboughaba/i3config.vim' " i3 config
" Plug 'chr4/nginx.vim' " nginx
" Plug 'wgwoods/vim-systemd-syntax' " systemd
" Plug 'cespare/vim-toml' " toml
" Plug 'jparise/vim-graphql' " graphql

" +-----+
" | LSP |
" +-----+

packadd! nvim-lspconfig

" +-----+
" | FZF |
" +-----+

if executable('fzf')
    packadd! fzf.vim
endif

" +---------+
" | Writing |
" +---------+

packadd! tabular " Align stuff (useful for markdown tables for example)
packadd! vim-grammarous " Show grammar mistakes
packadd! vim-wordy " Verify quality of writting (see :Wordy)
packadd! ale

" +-----+
" | PHP |
" +-----+

" Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}

" +------+
" | LISP |
" +------+

" Plug 'guns/vim-sexp', { 'for': ['clojure', 'scheme'] }
" Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': ['clojure', 'scheme'] }

" +---------+
" | Clojure |
" +---------+

" Plug 'guns/vim-clojure-highlight', {'for': 'clojure'}
" Plug 'guns/vim-clojure-static', {'for': 'clojure'}
" Plug 'tpope/vim-fireplace', {'for': 'clojure'}

" +-----+
" | CSS |
" +-----+

packadd! vim-css-color " Display the hexadecimal colors - useful for css and color config

" +-----+
" | CSV |
" +-----+


" +------------+
" | Treesitter |
" +------------+
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/playground'
