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

highlight White ctermfg=white ctermbg=NONE cterm=NONE

" General
highlight LineNr ctermfg=lightGray ctermbg=black cterm=NONE
highlight SignColumn ctermfg=black ctermbg=black cterm=NONE
highlight VertSplit ctermfg=black ctermbg=black cterm=NONE
highlight CursorLine ctermfg=NONE ctermbg=black cterm=bold
highlight CursorLineNr ctermfg=red ctermbg=black cterm=bold
highlight Todo ctermfg=red ctermbg=white cterm=bold
highlight NvimInternalError ctermfg=red ctermbg=NONE cterm=bold

highlight Search ctermfg=green ctermbg=NONE cterm=bold
highlight PreProc ctermfg=white ctermbg=NONE cterm=NONE
highlight Visual ctermfg=red ctermbg=black cterm=bold
highlight Statement ctermfg=blue ctermbg=NONE cterm=NONE
highlight Delimiter ctermfg=magenta ctermbg=NONE cterm=NONE
highlight Special ctermfg=cyan ctermbg=NONE cterm=NONE
highlight WarningMsg ctermfg=red ctermbg=black cterm=NONE

highlight ModeMsg ctermfg=red ctermbg=NONE cterm=bold

highlight IncSearch ctermfg=black ctermbg=lightGray cterm=NONE
highlight ColorColumn ctermfg=black ctermbg=lightGray cterm=NONE
highlight MaxLineChar ctermfg=black ctermbg=yellow cterm=NONE

" tabs
highlight TabLineSel ctermfg=white ctermbg=black cterm=bold
highlight TabLineNumSel ctermfg=red ctermbg=black cterm=bold
highlight TabLineModSel ctermfg=blue ctermbg=black cterm=NONE
highlight TabLineNum ctermfg=gray ctermbg=black cterm=NONE
highlight TabLine ctermfg=gray ctermbg=black cterm=NONE
highlight TabLineMod ctermfg=gray ctermbg=black cterm=NONE

" Status line
highlight StatusLine ctermfg=white ctermbg=black cterm=NONE
highlight StatusLineRO ctermfg=red ctermbg=black cterm=bold
highlight StatusLineFile ctermfg=white ctermbg=black cterm=bold
highlight StatusLineChange ctermfg=blue ctermbg=black cterm=bold
highlight StatusLineNC ctermfg=white ctermbg=black cterm=NONE
highlight StatusLineTerm ctermfg=black ctermbg=black cterm=NONE
highlight StatusLineTermNC ctermfg=black ctermbg=black cterm=NONE

" Used for autocompletion
highlight PMenu ctermfg=lightGray ctermbg=black cterm=NONE
highlight PMenuSel ctermfg=white ctermbg=red cterm=bold

" Directory
highlight Directory ctermfg=blue ctermbg=NONE cterm=bold

" Writting
highlight Underlined ctermfg=magenta ctermbg=black cterm=underline
highlight SpellLocal ctermfg=magenta ctermbg=NONE cterm=underline
highlight SpellRare ctermfg=blue ctermbg=NONE cterm=underline
highlight SpellBad ctermfg=red ctermbg=NONE cterm=underline
highlight SpellCap ctermfg=NONE ctermbg=red cterm=underline

highlight Folded ctermfg=white ctermbg=black cterm=bold

" Code
highlight Keyword ctermfg=blue ctermbg=NONE cterm=NONE
highlight Function ctermfg=white ctermbg=NONE cterm=NONE
highlight Comment ctermfg=gray ctermbg=NONE cterm=NONE
highlight LocalVariable ctermfg=magenta ctermbg=NONE cterm=NONE

highlight Float ctermfg=red ctermbg=NONE cterm=NONE
highlight Number ctermfg=red ctermbg=NONE cterm=NONE
highlight Boolean ctermfg=red ctermbg=NONE cterm=NONE
highlight String ctermfg=magenta ctermbg=NONE cterm=NONE
highlight Structure ctermfg=green ctermbg=NONE cterm=bold

highlight Type ctermfg=green ctermbg=NONE cterm=bold
highlight MatchParen ctermfg=magenta ctermbg=NONE cterm=bold
highlight Identifier ctermfg=cyan ctermbg=NONE cterm=NONE
highlight Operator ctermfg=white ctermbg=NONE cterm=NONE

highlight ColorColumn ctermfg=lightGray ctermbg=NONE cterm=NONE

" highlight @boolean ctermfg=red ctermbg=NONE cterm=NONE
" highlight @attribute ctermfg=green ctermbg=NONE cterm=NONE
" highlight @function ctermfg=cyan ctermbg=NONE cterm=NONE
" highlight @keyword.function ctermfg=blue ctermbg=NONE cterm=NONE
" highlight @keyword ctermfg=lightGray ctermbg=NONE cterm=NONE
" highlight @conditional ctermfg=lightGray ctermbg=NONE cterm=NONE
" highlight @repeat ctermfg=lightGray ctermbg=NONE cterm=NONE
" highlight @identifier ctermfg=lightGray ctermbg=NONE cterm=NONE
" highlight @variable ctermfg=blue ctermbg=NONE cterm=NONE
" highlight @variable.field ctermfg=white ctermbg=NONE cterm=NONE
" highlight @field ctermfg=white ctermbg=NONE cterm=NONE
" highlight @keyword ctermfg=lightGray ctermbg=NONE cterm=NONE
" highlight @keyword.operator ctermfg=lightGray ctermbg=NONE cterm=NONE
" highlight @keyword.return ctermfg=lightGray ctermbg=NONE cterm=NONE
" highlight @punctuation.bracket ctermfg=red ctermbg=NONE cterm=NONE
" highlight @operator ctermfg=red ctermbg=NONE cterm=NONE
" highlight @parameter ctermfg=green ctermbg=NONE cterm=NONE

" Markdown
highlight markdownH1 ctermfg=red ctermbg=NONE cterm=NONE
highlight markdownH2 ctermfg=yellow ctermbg=NONE cterm=NONE
highlight markdownH3 ctermfg=green ctermbg=NONE cterm=NONE
highlight markdownH4 ctermfg=blue ctermbg=NONE cterm=NONE
highlight markdownH5 ctermfg=cyan ctermbg=NONE cterm=NONE
highlight markdownH6 ctermfg=gray ctermbg=NONE cterm=NONE

" SQL

highlight sqlKeyword ctermfg=red ctermbg=NONE cterm=bold

" i3
highlight Special ctermfg=lightGray ctermbg=NONE cterm=NONE

"---------"
" PLUGINS "
"---------"

" Signify plugin + vim diff
highlight DiffDelete ctermfg=red ctermbg=black cterm=NONE
highlight DiffChange ctermfg=blue ctermbg=black cterm=NONE
highlight DiffAdd ctermfg=white ctermbg=black cterm=NONE
highlight DiffText ctermfg=yellow ctermbg=black cterm=NONE

" Neomake plugin
highlight NeomakeWarningSign ctermfg=yellow ctermbg=black

" quick-scope plugin
highlight QuickScopePrimary ctermfg=red cterm=underline
highlight QuickScopeSecondary ctermfg=yellow cterm=underline

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
"highlight WildMenu ctermfg=NONE ctermbg=248 cterm=NONE
"highlight SpecialComment ctermfg=1 ctermbg=NONE cterm=NONE
"highlight Typedef ctermfg=60 ctermbg=NONE cterm=bold
"highlight Title ctermfg=189 ctermbg=black cterm=bold
"highlight PreCondit ctermfg=1 ctermbg=NONE cterm=NONE
"highlight StatusLineNC ctermfg=black ctermbg=66 cterm=bold
"highlight NonText c ctermfg=66 ctermbg=NONE cterm=NONE
"highlight ErrorMsg ctermfg=248 ctermbg=88 cterm=NONE
"highlight Debug ctermfg=1 ctermbg=NONE cterm=NONE
"highlight SpecialChar ctermfg=1 ctermbg=NONE cterm=NONE
"highlight Conditional ctermfg=1 ctermbg=NONE cterm=bold
"highlight StorageClass ctermfg=60 tc=NONE cterm=bold
"highlight StatusLine ctermfg=black ctermbg=1 cterm=bold
"highlight Label ctermfg=1 ctermbg=NONE cterm=bold
"highlight Character ctermfg=248 ctermbg=NONE cterm=NONE
"highlight VisualNOS ctermfg=black ctermbg=189 cterm=underline
"highlight ModeMsg ctermfg=white ctermbg=black cterm=bold
"highlight Define ctermfg=1 ctermbg=NONE cterm=NONE
"highlight MoreMsg ctermfg=1 ctermbg=NONE cterm=bold
"highlight SpellCap ctermfg=189 ctermbg=black cterm=underline
"highlight Exception ctermfg=1 ctermbg=NONE cterm=bold
"highlight Error ctermfg=248 ctermbg=88 cterm=NONE
"highlight SpecialKey c ctermfg=66 ctermbg=NONE cterm=NONE
"highlight Constant ctermfg=248 ctermbg=NONE cterm=NONE
"highlight Tag ctermfg=1 ctermbg=NONE cterm=NONE
"highlight Macro ctermfg=1 ctermbg=ONE cterm=NONE
"highlight cursorim ctermfg=black ctermbg=10 cterm=NONE

" Treesitter

"highlight @annotation ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @attribute ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @boolean ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @character ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @character.special ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @comment ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @conceal ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @conditional ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @constant ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @constant.builtin ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @constant.macro ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @constructor ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @debug ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @define ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @error ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @exception ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @field ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @float ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @function ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @function.builtin ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @function.call ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @function.macro ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @include ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @keyword ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @keyword.function ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @keyword.operator ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @keyword.return ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @label ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @math ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @method ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @method.call ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @namespace ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @none ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @number ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @operator ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @parameter ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @parameter.reference ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @preproc ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @property ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @punctuation.bracket ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @punctuation.delimiter ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @punctuation.special ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @repeat ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @storageclass ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @storageclass.lifetime ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @strike ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @string ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @string.escape ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @string.regex ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @string.special ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @symbol ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @tag ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @tag.attribute ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @tag.delimiter ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.danger ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.diff.add ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.diff.delete ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.emphasis ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.environment ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.environment.name ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.literal ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.math ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.note ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.reference ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.strike ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.strong ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.title ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.todo ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.underline ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.uri ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @text.warning ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @todo ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @type ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @type.builtin ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @type.definition ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @type.qualifier ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @uri ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @variable ctermfg=lightGray ctermbg=black cterm=NONE
"highlight @variable.builtin ctermfg=lightGray ctermbg=black cterm=NONE
