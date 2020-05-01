let g:colors_name = 'hypnos'

" General
hi LineNr ctermfg=251 ctermbg=236 cterm=NONE
hi SignColumn ctermfg=236 ctermbg=236 cterm=NONE
hi VertSplit ctermfg=236 ctermbg=236 cterm=bold
hi CursorLine ctermfg=NONE ctermbg=236 cterm=bold
hi CursorLineNr ctermfg=red ctermbg=236 cterm=bold

hi Search ctermfg=yellow ctermbg=NONE cterm=bold
hi SpellRare ctermfg=yellow ctermbg=232 cterm=bold
hi PreProc ctermfg=white ctermbg=NONE cterm=NONE
hi Visual ctermfg=red ctermbg=236 cterm=bold
hi Statement ctermfg=blue ctermbg=NONE cterm=NONE
hi Delimiter ctermfg=magenta ctermbg=NONE cterm=NONE

hi WarningMsg ctermfg=red ctermbg=236 cterm=NONE

" tabs
hi TabLineSel ctermfg=red ctermbg=red cterm=bold
hi TabLineFill ctermfg=red ctermbg=red cterm=bold
hi TabLine ctermfg=red ctermbg=red cterm=bold

" Used for autocompletion
hi PMenu ctermfg=251 ctermbg=238 cterm=NONE
hi PMenuSel ctermfg=white ctermbg=red cterm=bold

" ???
" hi PMenuSbar ctermfg=NONE ctermbg=6 cterm=NONE
" hi PMenuThumb ctermfg=NONE ctermbg=6 cterm=NONE

" Directory
hi Directory ctermfg=blue ctermbg=NONE cterm=bold

" Writting
hi Underlined ctermfg=magenta ctermbg=236 cterm=underline
hi SpellBad ctermfg=white ctermbg=88 cterm=underline
hi Folded ctermfg=white ctermbg=239 cterm=bold

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
hi MatchParen ctermfg=236 ctermbg=yellow cterm=bold
hi Identifier ctermfg=white ctermbg=NONE cterm=NONE
hi Operator ctermfg=white ctermbg=NONE cterm=NONE

hi ColorColumn ctermfg=244 ctermbg=NONE cterm=NONE

" Markdown
hi markdownH1 ctermfg=red ctermbg=NONE cterm=NONE
hi markdownH2 ctermfg=yellow ctermbg=NONE cterm=NONE
hi markdownH3 ctermfg=green ctermbg=NONE cterm=NONE
hi markdownH4 ctermfg=blue ctermbg=NONE cterm=NONE
hi markdownH5 ctermfg=cyan ctermbg=NONE cterm=NONE

"---------"
" PLUGINS "
"---------"

" VDebug plugin
hi DbgCurrentLine ctermfg=white ctermbg=9
hi DbgCurrentSign ctermfg=red ctermbg=236
hi DbgBreakptLine ctermfg=white ctermbg=236
hi DbgBreakptSign ctermfg=red ctermbg=236

" Signify plugin + vim diff
hi DiffDelete ctermfg=red ctermbg=236 cterm=NONE
hi DiffChange ctermfg=blue ctermbg=236 cterm=NONE
hi DiffAdd ctermfg=white ctermbg=236 cterm=NONE
hi DiffText ctermfg=yellow ctermbg=236 cterm=NONE

" Neomake plugin
hi NeomakeWarningSign ctermfg=yellow ctermbg=236
hi SpellCap ctermfg=236 ctermbg=yellow cterm=bold

"hi CTagsMember-i  no settings --
"hi CTagsGlobalConstant-i  no settings --
"hi Ignore-i  no settings --
"hi Normal c0c5ce guibg=#192224 guisp=#192224 gui=NONE ctermfg=252 ctermbg=236 cterm=NONE
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
"hi Title ctermfg=189 ctermbg=236 cterm=bold
"hi PreCondit ctermfg=1 ctermbg=NONE cterm=NONE
"hi StatusLineNC ctermfg=236 ctermbg=66 cterm=bold
"hi NonText c ctermfg=66 ctermbg=NONE cterm=NONE
"hi ErrorMsg ctermfg=248 ctermbg=88 cterm=NONE
"hi Debug ctermfg=1 ctermbg=NONE cterm=NONE
"hi SpecialChar ctermfg=1 ctermbg=NONE cterm=NONE
"hi Conditional ctermfg=1 ctermbg=NONE cterm=bold
"hi StorageClass ctermfg=60 tc=NONE cterm=bold
"hi Todo ctermfg=189 ctermbg=1 cterm=NONE
"hi Special ctermfg=228 ctermbg=NONE cterm=NONE
"hi StatusLine ctermfg=236 ctermbg=1 cterm=bold
"hi Label ctermfg=1 ctermbg=NONE cterm=bold
"hi Character ctermfg=248 ctermbg=NONE cterm=NONE
"hi VisualNOS ctermfg=236 ctermbg=189 cterm=underline
"hi ModeMsg ctermfg=white ctermbg=236 cterm=bold
"hi Define ctermfg=1 ctermbg=NONE cterm=NONE
"hi MoreMsg ctermfg=1 ctermbg=NONE cterm=bold
"hi SpellCap ctermfg=189 ctermbg=236 cterm=underline
"hi Exception ctermfg=1 ctermbg=NONE cterm=bold
"hi Error ctermfg=248 ctermbg=88 cterm=NONE
"hi SpecialKey c ctermfg=66 ctermbg=NONE cterm=NONE
"hi Constant ctermfg=248 ctermbg=NONE cterm=NONE
"hi Tag ctermfg=1 ctermbg=NONE cterm=NONE
"hi Repeat ctermfg=1 ctermbg=NONE cterm=bold
"hi Macro ctermfg=1 ctermbg=ONE cterm=NONE
"hi cursorim ctermfg=236 ctermbg=10 cterm=NONE
