" =============================================================================
" Filename: autoload/lightline/colorscheme/hypnos256.vim
" Author: atweiden
" License: MIT License
" Last Change: 2015/11/02 08:23:27.
" =============================================================================
let s:base03 = [ '#151513', 233 ]
let s:base02 = [ '#30302c', 236 ]
let s:base01 = [ '#4e4e43', 239 ]
let s:base00 = [ '#666656', 242  ]
let s:base0 = [ '#808070', 244 ]
let s:base1 = [ '#949484', 246 ]
let s:base2 = [ '#a8a897', 248 ]
let s:base3 = [ '#1C1C1C', 234 ]
let s:yellow = [ '#ffd75f', 221 ]
let s:orange = []
let s:magenta = [ '#afafd7', 103 ]
let s:peach = []
let s:blue = [ '#87afaf', 109 ]
let s:cyan = [ '#87afaf', 109 ]
let s:green = [ '#87AF87', 108 ]
let s:white = [ '#ffffff', 15 ]
let s:red = [ '#d44042', 167 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base02, s:blue ], [ s:base3, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:base1 ], [ s:base2, s:base01 ] ]
let s:p.inactive.right = [ [ s:base02, s:base00 ], [ s:base0, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:base02, s:red ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:base02, s:magenta ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:base02, s:yellow], [ s:base3, s:base01 ] ]
let s:p.normal.middle = [ [ s:base0, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
let s:p.tabline.left = [ [ s:base3, s:base00 ] ]
let s:p.tabline.tabsel = [ [ s:base3, s:base02 ] ]
let s:p.tabline.middle = [ [ s:base01, s:base1 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:red, s:base02 ] ]
let s:p.normal.warning = [ [ s:yellow, s:base01 ] ]

let g:lightline#colorscheme#hypnos256#palette = lightline#colorscheme#flatten(s:p)
