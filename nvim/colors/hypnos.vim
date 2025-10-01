" NR-16 COLOR NAME
" 0     Black
" 1     DarkBlue
" 2     DarkGreen
" 3     DarkCyan
" 4     DarkRed
" 5     DarkMagenta
" 6     Brown, DarkYellow
" 7     LightGray, LightGrey, Gray, Grey
" 8     DarkGray, DarkGrey
" 9     Blue, LightBlue
" 10    Green, LightGreen
" 11    Cyan, LightCyan
" 12    Red, LightRed
" 13    Magenta, LightMagenta
" 14    Yellow, LightYellow
" 15    White

let g:colors_name = 'hypnos'

" Linking Group

highlight White ctermfg=white ctermbg=none cterm=none

" General
highlight LineNr ctermfg=lightGray ctermbg=black cterm=none
highlight SignColumn ctermfg=black ctermbg=black cterm=none
highlight VertSplit ctermfg=black ctermbg=black cterm=none
highlight CursorLine ctermfg=none ctermbg=black cterm=bold
highlight CursorLineNr ctermfg=red ctermbg=black cterm=bold
highlight Todo ctermfg=red ctermbg=white cterm=bold
highlight NvimInternalError ctermfg=red ctermbg=none cterm=bold

highlight Search ctermfg=green ctermbg=none cterm=bold
highlight PreProc ctermfg=white ctermbg=none cterm=none
highlight Visual ctermfg=red ctermbg=black cterm=bold
highlight Statement ctermfg=blue ctermbg=none cterm=none
highlight Delimiter ctermfg=magenta ctermbg=none cterm=none
highlight Special ctermfg=cyan ctermbg=none cterm=none
highlight WarningMsg ctermfg=red ctermbg=black cterm=none

highlight ModeMsg ctermfg=red ctermbg=none cterm=bold

highlight IncSearch ctermfg=black ctermbg=lightGray cterm=none
highlight ColorColumn ctermfg=black ctermbg=lightGray cterm=none
highlight MaxLineChar ctermfg=black ctermbg=yellow cterm=none

" tabs
highlight TabLineSel ctermfg=white ctermbg=black cterm=bold
highlight TabLineNumSel ctermfg=red ctermbg=black cterm=bold
highlight TabLineModSel ctermfg=blue ctermbg=black cterm=none
highlight TabLineNum ctermfg=gray ctermbg=black cterm=none
highlight TabLine ctermfg=gray ctermbg=black cterm=none
highlight TabLineMod ctermfg=gray ctermbg=black cterm=none

" Status line
highlight StatusLine ctermfg=white ctermbg=black cterm=none
highlight StatusLineRO ctermfg=red ctermbg=black cterm=bold
highlight StatusLineFile ctermfg=white ctermbg=black cterm=bold
highlight StatusLineChange ctermfg=blue ctermbg=black cterm=bold
highlight StatusLineNC ctermfg=white ctermbg=black cterm=none
highlight StatusLineTerm ctermfg=white ctermbg=black cterm=none
highlight StatusLineTermNC ctermfg=white ctermbg=black cterm=none

" Used for autocompletion
highlight! default link PMenu LineNr
highlight PMenuSel ctermfg=white ctermbg=red cterm=bold

" Directory
highlight Directory ctermfg=blue ctermbg=none cterm=bold

" Writting
highlight Underlined ctermfg=magenta ctermbg=black cterm=underline
highlight SpellLocal ctermfg=magenta ctermbg=none cterm=underline
highlight SpellRare ctermfg=blue ctermbg=none cterm=underline
highlight SpellBad ctermfg=red ctermbg=none cterm=underline
highlight SpellCap ctermfg=none ctermbg=red cterm=underline

highlight Folded ctermfg=white ctermbg=black cterm=bold

" Code
highlight Keyword ctermfg=blue ctermbg=none cterm=none
highlight Function ctermfg=white ctermbg=none cterm=none
highlight Comment ctermfg=gray ctermbg=none cterm=none
highlight LocalVariable ctermfg=magenta ctermbg=none cterm=none

highlight Float ctermfg=red ctermbg=none cterm=none
highlight Number ctermfg=red ctermbg=none cterm=none
highlight Boolean ctermfg=red ctermbg=none cterm=none
highlight String ctermfg=magenta ctermbg=none cterm=none
highlight Structure ctermfg=green ctermbg=none cterm=bold

highlight Type ctermfg=green ctermbg=none cterm=bold
highlight MatchParen ctermfg=magenta ctermbg=none cterm=bold
highlight Identifier ctermfg=cyan ctermbg=none cterm=none
highlight Operator ctermfg=white ctermbg=none cterm=none

highlight ColorColumn ctermfg=lightGray ctermbg=none cterm=none

" highlight @boolean ctermfg=red ctermbg=none cterm=none
" highlight @attribute ctermfg=green ctermbg=none cterm=none
" highlight @function ctermfg=cyan ctermbg=none cterm=none
" highlight @keyword.function ctermfg=blue ctermbg=none cterm=none
" highlight @keyword ctermfg=lightGray ctermbg=none cterm=none
" highlight @conditional ctermfg=lightGray ctermbg=none cterm=none
" highlight @repeat ctermfg=lightGray ctermbg=none cterm=none
" highlight @identifier ctermfg=lightGray ctermbg=none cterm=none
" highlight @variable ctermfg=blue ctermbg=none cterm=none
" highlight @variable.field ctermfg=white ctermbg=none cterm=none
" highlight @field ctermfg=white ctermbg=none cterm=none
" highlight @keyword ctermfg=lightGray ctermbg=none cterm=none
" highlight @keyword.operator ctermfg=lightGray ctermbg=none cterm=none
" highlight @keyword.return ctermfg=lightGray ctermbg=none cterm=none
" highlight @punctuation.bracket ctermfg=red ctermbg=none cterm=none
" highlight @operator ctermfg=red ctermbg=none cterm=none
" highlight @parameter ctermfg=green ctermbg=none cterm=none

" Markdown
highlight markdownH1 ctermfg=red ctermbg=none cterm=none
highlight markdownH2 ctermfg=yellow ctermbg=none cterm=none
highlight markdownH3 ctermfg=green ctermbg=none cterm=none
highlight markdownH4 ctermfg=blue ctermbg=none cterm=none
highlight markdownH5 ctermfg=cyan ctermbg=none cterm=none
highlight markdownH6 ctermfg=gray ctermbg=none cterm=none

" SQL

highlight sqlKeyword ctermfg=red ctermbg=none cterm=bold

" i3
highlight Special ctermfg=lightGray ctermbg=none cterm=none

"---------"
" PLUGINS "
"---------"

" Signify plugin + vim diff
highlight DiffDelete ctermfg=red ctermbg=black cterm=none
highlight DiffChange ctermfg=blue ctermbg=black cterm=none
highlight DiffAdd ctermfg=white ctermbg=black cterm=none
highlight DiffText ctermfg=yellow ctermbg=black cterm=none

" Neomake plugin
highlight NeomakeWarningSign ctermfg=yellow ctermbg=black

" quick-scope plugin
highlight QuickScopePrimary ctermfg=red cterm=underline
highlight QuickScopeSecondary ctermfg=yellow cterm=underline

highlight netrwMarkFile ctermfg=red cterm=underline

" NOT USED

"highlight CTagsMember-i  no settings --
"highlight CTagsGlobalConstant-i  no settings --
"highlight Ignore-i  no settings --
"highlight Normal c0c5ce
"highlight CTagsImport-i  no settings --
"highlight CTagsGlobalVariable-i  no settings --
"highlight EnumerationValue-i  no settings --
"highlight Union-i  no settings --
"highlight Question-i  no settings --
"highlight EnumerationName-i  no settings --
"highlight DefinedName-i  no settings --
"highlight LocalVariable-i  no settings --
"highlight CTagsClass-i  no settings --
"highlight clear-i  no settings --
"highlight WildMenu ctermfg=none ctermbg=248 cterm=none
"highlight SpecialComment ctermfg=1 ctermbg=none cterm=none
"highlight Typedef ctermfg=60 ctermbg=none cterm=bold
"highlight Title ctermfg=189 ctermbg=black cterm=bold
"highlight PreCondit ctermfg=1 ctermbg=none cterm=none
"highlight StatusLineNC ctermfg=black ctermbg=66 cterm=bold
"highlight NonText c ctermfg=66 ctermbg=none cterm=none
"highlight ErrorMsg ctermfg=248 ctermbg=88 cterm=none
"highlight Debug ctermfg=1 ctermbg=none cterm=none
"highlight SpecialChar ctermfg=1 ctermbg=none cterm=none
"highlight Conditional ctermfg=1 ctermbg=none cterm=bold
"highlight StorageClass ctermfg=60 tc=none cterm=bold
"highlight StatusLine ctermfg=black ctermbg=1 cterm=bold
"highlight Label ctermfg=1 ctermbg=none cterm=bold
"highlight Character ctermfg=248 ctermbg=none cterm=none
"highlight VisualNOS ctermfg=black ctermbg=189 cterm=underline
"highlight ModeMsg ctermfg=white ctermbg=black cterm=bold
"highlight Define ctermfg=1 ctermbg=none cterm=none
"highlight MoreMsg ctermfg=1 ctermbg=none cterm=bold
"highlight SpellCap ctermfg=189 ctermbg=black cterm=underline
"highlight Exception ctermfg=1 ctermbg=none cterm=bold
"highlight Error ctermfg=248 ctermbg=88 cterm=none
"highlight SpecialKey c ctermfg=66 ctermbg=none cterm=none
"highlight Constant ctermfg=248 ctermbg=none cterm=none
"highlight Tag ctermfg=1 ctermbg=none cterm=none
"highlight Macro ctermfg=1 ctermbg=ONE cterm=none
"highlight cursorim ctermfg=black ctermbg=10 cterm=none

" Treesitter

"highlight @annotation ctermfg=lightGray ctermbg=black cterm=none
"highlight @attribute ctermfg=lightGray ctermbg=black cterm=none
"highlight @boolean ctermfg=lightGray ctermbg=black cterm=none
"highlight @character ctermfg=lightGray ctermbg=black cterm=none
"highlight @character.special ctermfg=lightGray ctermbg=black cterm=none
"highlight @comment ctermfg=lightGray ctermbg=black cterm=none
"highlight @conceal ctermfg=lightGray ctermbg=black cterm=none
"highlight @conditional ctermfg=lightGray ctermbg=black cterm=none
"highlight @constant ctermfg=lightGray ctermbg=black cterm=none
"highlight @constant.builtin ctermfg=lightGray ctermbg=black cterm=none
"highlight @constant.macro ctermfg=lightGray ctermbg=black cterm=none
"highlight @constructor ctermfg=lightGray ctermbg=black cterm=none
"highlight @debug ctermfg=lightGray ctermbg=black cterm=none
"highlight @define ctermfg=lightGray ctermbg=black cterm=none
"highlight @error ctermfg=lightGray ctermbg=black cterm=none
"highlight @exception ctermfg=lightGray ctermbg=black cterm=none
"highlight @field ctermfg=lightGray ctermbg=black cterm=none
"highlight @float ctermfg=lightGray ctermbg=black cterm=none
"highlight @function ctermfg=lightGray ctermbg=black cterm=none
"highlight @function.builtin ctermfg=lightGray ctermbg=black cterm=none
"highlight @function.call ctermfg=lightGray ctermbg=black cterm=none
"highlight @function.macro ctermfg=lightGray ctermbg=black cterm=none
"highlight @include ctermfg=lightGray ctermbg=black cterm=none
"highlight @keyword ctermfg=lightGray ctermbg=black cterm=none
"highlight @keyword.function ctermfg=lightGray ctermbg=black cterm=none
"highlight @keyword.operator ctermfg=lightGray ctermbg=black cterm=none
"highlight @keyword.return ctermfg=lightGray ctermbg=black cterm=none
"highlight @label ctermfg=lightGray ctermbg=black cterm=none
"highlight @math ctermfg=lightGray ctermbg=black cterm=none
"highlight @method ctermfg=lightGray ctermbg=black cterm=none
"highlight @method.call ctermfg=lightGray ctermbg=black cterm=none
"highlight @namespace ctermfg=lightGray ctermbg=black cterm=none
"highlight @none ctermfg=lightGray ctermbg=black cterm=none
"highlight @number ctermfg=lightGray ctermbg=black cterm=none
"highlight @operator ctermfg=lightGray ctermbg=black cterm=none
"highlight @parameter ctermfg=lightGray ctermbg=black cterm=none
"highlight @parameter.reference ctermfg=lightGray ctermbg=black cterm=none
"highlight @preproc ctermfg=lightGray ctermbg=black cterm=none
"highlight @property ctermfg=lightGray ctermbg=black cterm=none
"highlight @punctuation.bracket ctermfg=lightGray ctermbg=black cterm=none
"highlight @punctuation.delimiter ctermfg=lightGray ctermbg=black cterm=none
"highlight @punctuation.special ctermfg=lightGray ctermbg=black cterm=none
"highlight @repeat ctermfg=lightGray ctermbg=black cterm=none
"highlight @storageclass ctermfg=lightGray ctermbg=black cterm=none
"highlight @storageclass.lifetime ctermfg=lightGray ctermbg=black cterm=none
"highlight @strike ctermfg=lightGray ctermbg=black cterm=none
"highlight @string ctermfg=lightGray ctermbg=black cterm=none
"highlight @string.escape ctermfg=lightGray ctermbg=black cterm=none
"highlight @string.regex ctermfg=lightGray ctermbg=black cterm=none
"highlight @string.special ctermfg=lightGray ctermbg=black cterm=none
"highlight @symbol ctermfg=lightGray ctermbg=black cterm=none
"highlight @tag ctermfg=lightGray ctermbg=black cterm=none
"highlight @tag.attribute ctermfg=lightGray ctermbg=black cterm=none
"highlight @tag.delimiter ctermfg=lightGray ctermbg=black cterm=none
"highlight @text ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.danger ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.diff.add ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.diff.delete ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.emphasis ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.environment ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.environment.name ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.literal ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.math ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.note ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.reference ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.strike ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.strong ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.title ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.todo ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.underline ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.uri ctermfg=lightGray ctermbg=black cterm=none
"highlight @text.warning ctermfg=lightGray ctermbg=black cterm=none
"highlight @todo ctermfg=lightGray ctermbg=black cterm=none
"highlight @type ctermfg=lightGray ctermbg=black cterm=none
"highlight @type.builtin ctermfg=lightGray ctermbg=black cterm=none
"highlight @type.definition ctermfg=lightGray ctermbg=black cterm=none
"highlight @type.qualifier ctermfg=lightGray ctermbg=black cterm=none
"highlight @uri ctermfg=lightGray ctermbg=black cterm=none
"highlight @variable ctermfg=lightGray ctermbg=black cterm=none
"highlight @variable.builtin ctermfg=lightGray ctermbg=black cterm=none
