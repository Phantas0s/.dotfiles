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

hi White ctermfg=white ctermbg=NONE cterm=NONE

" General
hi LineNr ctermfg=lightGray ctermbg=black cterm=NONE
hi SignColumn ctermfg=black ctermbg=black cterm=NONE
hi VertSplit ctermfg=black ctermbg=black cterm=NONE
hi CursorLine ctermfg=NONE ctermbg=black cterm=bold
hi CursorLineNr ctermfg=red ctermbg=black cterm=bold
hi Todo ctermfg=red ctermbg=white cterm=bold
hi NvimInternalError ctermfg=red ctermbg=NONE cterm=bold

hi Search ctermfg=yellow ctermbg=NONE cterm=bold
hi PreProc ctermfg=white ctermbg=NONE cterm=NONE
hi Visual ctermfg=red ctermbg=black cterm=bold
hi Statement ctermfg=blue ctermbg=NONE cterm=NONE
hi Delimiter ctermfg=magenta ctermbg=NONE cterm=NONE
hi Special ctermfg=cyan ctermbg=NONE cterm=NONE
hi WarningMsg ctermfg=red ctermbg=black cterm=NONE

hi ModeMsg ctermfg=red ctermbg=NONE cterm=bold

hi IncSearch ctermfg=black ctermbg=lightGray cterm=NONE
hi ColorColumn ctermfg=black ctermbg=lightGray cterm=NONE
hi MaxLineChar ctermfg=black ctermbg=yellow cterm=NONE

" tabs
hi TabLineSel ctermfg=white ctermbg=black cterm=bold
hi TabLineNumSel ctermfg=red ctermbg=black cterm=bold
hi TabLineModSel ctermfg=blue ctermbg=black cterm=NONE
hi TabLineNum ctermfg=gray ctermbg=black cterm=NONE
hi TabLine ctermfg=gray ctermbg=black cterm=NONE
hi TabLineMod ctermfg=gray ctermbg=black cterm=NONE

" Status line
hi StatusLine ctermfg=white ctermbg=black cterm=NONE
hi StatusLineRO ctermfg=red ctermbg=black cterm=bold
hi StatusLineFile ctermfg=white ctermbg=black cterm=bold
hi StatusLineChange ctermfg=blue ctermbg=black cterm=bold
hi StatusLineNC ctermfg=gray ctermbg=black cterm=NONE

" Used for autocompletion
hi PMenu ctermfg=lightGray ctermbg=black cterm=NONE
hi PMenuSel ctermfg=white ctermbg=red cterm=bold

" Directory
hi Directory ctermfg=blue ctermbg=NONE cterm=bold

" Writting
hi Underlined ctermfg=magenta ctermbg=black cterm=underline
hi SpellRare ctermfg=yellow ctermbg=black cterm=bold
hi SpellBad ctermfg=red ctermbg=NONE cterm=underline
hi SpellCap ctermfg=NONE ctermbg=red cterm=bold
hi Folded ctermfg=white ctermbg=black cterm=bold

" Code
hi Keyword ctermfg=blue ctermbg=NONE cterm=NONE
hi Function ctermfg=white ctermbg=NONE cterm=NONE
hi Comment ctermfg=gray ctermbg=NONE cterm=NONE
hi LocalVariable ctermfg=magenta ctermbg=NONE cterm=NONE

hi Float ctermfg=red ctermbg=NONE cterm=NONE
hi Number ctermfg=red ctermbg=NONE cterm=NONE
hi Boolean ctermfg=red ctermbg=NONE cterm=NONE
hi String ctermfg=magenta ctermbg=NONE cterm=NONE
hi Structure ctermfg=green ctermbg=NONE cterm=bold

hi Type ctermfg=green ctermbg=NONE cterm=bold
hi MatchParen ctermfg=yellow ctermbg=NONE cterm=bold
hi Identifier ctermfg=cyan ctermbg=NONE cterm=NONE
hi Operator ctermfg=white ctermbg=NONE cterm=NONE

hi ColorColumn ctermfg=lightGray ctermbg=NONE cterm=NONE

hi @boolean ctermfg=red ctermbg=NONE cterm=NONE
hi @attribute ctermfg=green ctermbg=NONE cterm=NONE
hi @function ctermfg=cyan ctermbg=NONE cterm=NONE
hi @keyword.function ctermfg=blue ctermbg=black cterm=NONE
hi @keyword ctermfg=lightGray ctermbg=NONE cterm=NONE
hi @conditional ctermfg=lightGray ctermbg=NONE cterm=NONE
hi @repeat ctermfg=lightGray ctermbg=NONE cterm=NONE
hi @identifier ctermfg=lightGray ctermbg=NONE cterm=NONE
hi @variable ctermfg=blue ctermbg=NONE cterm=NONE
hi @variable.field ctermfg=white ctermbg=NONE cterm=NONE
hi @field ctermfg=white ctermbg=NONE cterm=NONE
hi @keyword ctermfg=lightGray ctermbg=NONE cterm=NONE
hi @keyword.operator ctermfg=lightGray ctermbg=NONE cterm=NONE
hi @keyword.return ctermfg=lightGray ctermbg=NONE cterm=NONE
" hi @punctuation.bracket ctermfg=red ctermbg=NONE cterm=NONE
" hi @operator ctermfg=red ctermbg=NONE cterm=NONE
hi @parameter ctermfg=green ctermbg=NONE cterm=NONE

" Markdown
hi markdownH1 ctermfg=red ctermbg=NONE cterm=NONE
hi markdownH2 ctermfg=yellow ctermbg=NONE cterm=NONE
hi markdownH3 ctermfg=green ctermbg=NONE cterm=NONE
hi markdownH4 ctermfg=blue ctermbg=NONE cterm=NONE
hi markdownH5 ctermfg=cyan ctermbg=NONE cterm=NONE

" SQL

hi sqlKeyword ctermfg=red ctermbg=NONE cterm=bold

" i3
hi Special ctermfg=lightGray ctermbg=NONE cterm=NONE

"---------"
" PLUGINS "
"---------"

" Signify plugin + vim diff
hi DiffDelete ctermfg=red ctermbg=black cterm=NONE
hi DiffChange ctermfg=blue ctermbg=black cterm=NONE
hi DiffAdd ctermfg=white ctermbg=black cterm=NONE
hi DiffText ctermfg=yellow ctermbg=black cterm=NONE

" Neomake plugin
hi NeomakeWarningSign ctermfg=yellow ctermbg=black

" quick-scope plugin
highlight QuickScopePrimary ctermfg=red cterm=underline
highlight QuickScopeSecondary ctermfg=yellow cterm=underline

" NOT USED

"hi CTagsMember-i  no settings --
"hi CTagsGlobalConstant-i  no settings --
"hi Ignore-i  no settings --
"hi Normal c0c5ce guibg=#192224 guisp=#192224 gui=NONE ctermfg=252 ctermbg=black cterm=NONE
"hi CTagsImport-i  no settings --
"hi CTagsGlobalVariable-i  no settings --
"hi EnumerationValue-i  no settings --
"hi Union-i  no settings --
"hi Question-i  no settings --
"hi EnumerationName-i  no settings --
"hi DefinedName-i  no settings --
"hi LocalVariable-i  no settings --
"hi CTagsClass-i  no settings --
"hi clear-i  no settings --
"hi WildMenu ctermfg=NONE ctermbg=248 cterm=NONE
"hi SpecialComment ctermfg=1 ctermbg=NONE cterm=NONE
"hi Typedef ctermfg=60 ctermbg=NONE cterm=bold
"hi Title ctermfg=189 ctermbg=black cterm=bold
"hi PreCondit ctermfg=1 ctermbg=NONE cterm=NONE
"hi StatusLineNC ctermfg=black ctermbg=66 cterm=bold
"hi NonText c ctermfg=66 ctermbg=NONE cterm=NONE
"hi ErrorMsg ctermfg=248 ctermbg=88 cterm=NONE
"hi Debug ctermfg=1 ctermbg=NONE cterm=NONE
"hi SpecialChar ctermfg=1 ctermbg=NONE cterm=NONE
"hi Conditional ctermfg=1 ctermbg=NONE cterm=bold
"hi StorageClass ctermfg=60 tc=NONE cterm=bold
"hi StatusLine ctermfg=black ctermbg=1 cterm=bold
"hi Label ctermfg=1 ctermbg=NONE cterm=bold
"hi Character ctermfg=248 ctermbg=NONE cterm=NONE
"hi VisualNOS ctermfg=black ctermbg=189 cterm=underline
"hi ModeMsg ctermfg=white ctermbg=black cterm=bold
"hi Define ctermfg=1 ctermbg=NONE cterm=NONE
"hi MoreMsg ctermfg=1 ctermbg=NONE cterm=bold
"hi SpellCap ctermfg=189 ctermbg=black cterm=underline
"hi Exception ctermfg=1 ctermbg=NONE cterm=bold
"hi Error ctermfg=248 ctermbg=88 cterm=NONE
"hi SpecialKey c ctermfg=66 ctermbg=NONE cterm=NONE
"hi Constant ctermfg=248 ctermbg=NONE cterm=NONE
"hi Tag ctermfg=1 ctermbg=NONE cterm=NONE
"hi Macro ctermfg=1 ctermbg=ONE cterm=NONE
"hi cursorim ctermfg=black ctermbg=10 cterm=NONE

" Treesitter

"hi @annotation ctermfg=lightGray ctermbg=black cterm=NONE
"hi @attribute ctermfg=lightGray ctermbg=black cterm=NONE
"hi @boolean ctermfg=lightGray ctermbg=black cterm=NONE
"hi @character ctermfg=lightGray ctermbg=black cterm=NONE
"hi @character.special ctermfg=lightGray ctermbg=black cterm=NONE
"hi @comment ctermfg=lightGray ctermbg=black cterm=NONE
"hi @conceal ctermfg=lightGray ctermbg=black cterm=NONE
"hi @conditional ctermfg=lightGray ctermbg=black cterm=NONE
"hi @constant ctermfg=lightGray ctermbg=black cterm=NONE
"hi @constant.builtin ctermfg=lightGray ctermbg=black cterm=NONE
"hi @constant.macro ctermfg=lightGray ctermbg=black cterm=NONE
"hi @constructor ctermfg=lightGray ctermbg=black cterm=NONE
"hi @debug ctermfg=lightGray ctermbg=black cterm=NONE
"hi @define ctermfg=lightGray ctermbg=black cterm=NONE
"hi @error ctermfg=lightGray ctermbg=black cterm=NONE
"hi @exception ctermfg=lightGray ctermbg=black cterm=NONE
"hi @field ctermfg=lightGray ctermbg=black cterm=NONE
"hi @float ctermfg=lightGray ctermbg=black cterm=NONE
"hi @function ctermfg=lightGray ctermbg=black cterm=NONE
"hi @function.builtin ctermfg=lightGray ctermbg=black cterm=NONE
"hi @function.call ctermfg=lightGray ctermbg=black cterm=NONE
"hi @function.macro ctermfg=lightGray ctermbg=black cterm=NONE
"hi @include ctermfg=lightGray ctermbg=black cterm=NONE
"hi @keyword ctermfg=lightGray ctermbg=black cterm=NONE
"hi @keyword.function ctermfg=lightGray ctermbg=black cterm=NONE
"hi @keyword.operator ctermfg=lightGray ctermbg=black cterm=NONE
"hi @keyword.return ctermfg=lightGray ctermbg=black cterm=NONE
"hi @label ctermfg=lightGray ctermbg=black cterm=NONE
"hi @math ctermfg=lightGray ctermbg=black cterm=NONE
"hi @method ctermfg=lightGray ctermbg=black cterm=NONE
"hi @method.call ctermfg=lightGray ctermbg=black cterm=NONE
"hi @namespace ctermfg=lightGray ctermbg=black cterm=NONE
"hi @none ctermfg=lightGray ctermbg=black cterm=NONE
"hi @number ctermfg=lightGray ctermbg=black cterm=NONE
"hi @operator ctermfg=lightGray ctermbg=black cterm=NONE
"hi @parameter ctermfg=lightGray ctermbg=black cterm=NONE
"hi @parameter.reference ctermfg=lightGray ctermbg=black cterm=NONE
"hi @preproc ctermfg=lightGray ctermbg=black cterm=NONE
"hi @property ctermfg=lightGray ctermbg=black cterm=NONE
"hi @punctuation.bracket ctermfg=lightGray ctermbg=black cterm=NONE
"hi @punctuation.delimiter ctermfg=lightGray ctermbg=black cterm=NONE
"hi @punctuation.special ctermfg=lightGray ctermbg=black cterm=NONE
"hi @repeat ctermfg=lightGray ctermbg=black cterm=NONE
"hi @storageclass ctermfg=lightGray ctermbg=black cterm=NONE
"hi @storageclass.lifetime ctermfg=lightGray ctermbg=black cterm=NONE
"hi @strike ctermfg=lightGray ctermbg=black cterm=NONE
"hi @string ctermfg=lightGray ctermbg=black cterm=NONE
"hi @string.escape ctermfg=lightGray ctermbg=black cterm=NONE
"hi @string.regex ctermfg=lightGray ctermbg=black cterm=NONE
"hi @string.special ctermfg=lightGray ctermbg=black cterm=NONE
"hi @symbol ctermfg=lightGray ctermbg=black cterm=NONE
"hi @tag ctermfg=lightGray ctermbg=black cterm=NONE
"hi @tag.attribute ctermfg=lightGray ctermbg=black cterm=NONE
"hi @tag.delimiter ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.danger ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.diff.add ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.diff.delete ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.emphasis ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.environment ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.environment.name ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.literal ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.math ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.note ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.reference ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.strike ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.strong ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.title ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.todo ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.underline ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.uri ctermfg=lightGray ctermbg=black cterm=NONE
"hi @text.warning ctermfg=lightGray ctermbg=black cterm=NONE
"hi @todo ctermfg=lightGray ctermbg=black cterm=NONE
"hi @type ctermfg=lightGray ctermbg=black cterm=NONE
"hi @type.builtin ctermfg=lightGray ctermbg=black cterm=NONE
"hi @type.definition ctermfg=lightGray ctermbg=black cterm=NONE
"hi @type.qualifier ctermfg=lightGray ctermbg=black cterm=NONE
"hi @uri ctermfg=lightGray ctermbg=black cterm=NONE
"hi @variable ctermfg=lightGray ctermbg=black cterm=NONE
"hi @variable.builtin ctermfg=lightGray ctermbg=black cterm=NONE
