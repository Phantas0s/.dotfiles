let g:colors_name = 'hypnos'

" Linking Group

hi RedBold ctermfg=red ctermbg=red cterm=bold

" General
hi LineNr ctermfg=lightGray ctermbg=black cterm=NONE
hi SignColumn ctermfg=black ctermbg=black cterm=NONE
hi VertSplit ctermfg=black ctermbg=black cterm=NONE
hi CursorLine ctermfg=NONE ctermbg=black cterm=bold
hi CursorLineNr ctermfg=red ctermbg=black cterm=bold
hi Todo ctermfg=red ctermbg=white cterm=bold

hi Search ctermfg=yellow ctermbg=NONE cterm=bold
hi PreProc ctermfg=white ctermbg=NONE cterm=NONE
hi Visual ctermfg=red ctermbg=black cterm=bold
hi Statement ctermfg=blue ctermbg=NONE cterm=NONE
hi Delimiter ctermfg=magenta ctermbg=NONE cterm=NONE
hi Special ctermfg=cyan ctermbg=NONE cterm=NONE

hi WarningMsg ctermfg=red ctermbg=black cterm=NONE

" tabs
hi! link TabLineSel RedBold
hi! link TabLineFill RedBold
hi! link TabLine RedBold

" Used for autocompletion
hi PMenu ctermfg=lightGray ctermbg=black cterm=NONE
hi PMenuSel ctermfg=white ctermbg=red cterm=bold

" Directory
hi Directory ctermfg=blue ctermbg=NONE cterm=bold

" Writting
hi Underlined ctermfg=magenta ctermbg=black cterm=underline
hi SpellRare ctermfg=yellow ctermbg=black cterm=bold
hi SpellBad ctermfg=red ctermbg=NONE cterm=underline
hi Folded ctermfg=white ctermbg=black cterm=bold

" Code
hi Keyword ctermfg=blue ctermbg=NONE cterm=NONE
hi Function ctermfg=cyan ctermbg=NONE cterm=NONE
hi Comment ctermfg=249 ctermbg=NONE cterm=NONE
hi LocalVariable ctermfg=magenta ctermbg=NONE cterm=NONE

hi Float ctermfg=red ctermbg=NONE cterm=NONE
hi Number ctermfg=red ctermbg=NONE cterm=NONE
hi Boolean ctermfg=red ctermbg=NONE cterm=NONE
hi String ctermfg=magenta ctermbg=NONE cterm=NONE
hi Structure ctermfg=green ctermbg=NONE cterm=bold

hi Type ctermfg=green ctermbg=NONE cterm=bold
hi MatchParen ctermfg=green ctermbg=NONE cterm=bold
hi Identifier ctermfg=cyan ctermbg=NONE cterm=NONE
hi Operator ctermfg=white ctermbg=NONE cterm=NONE

hi ColorColumn ctermfg=lightGray ctermbg=NONE cterm=NONE

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
hi SpellCap ctermfg=NONE ctermbg=red cterm=bold

" quick-scope plugin
highlight QuickScopePrimary ctermfg=red cterm=underline
highlight QuickScopeSecondary ctermfg=yellow cterm=underline

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
