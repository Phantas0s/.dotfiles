" =============================================================================
" Filename: autoload/lightline/colorscheme/hypnos256.vim
" Author: Matthieu
" License: MIT License
" Last Change: 2018-04-13
" =============================================================================

let s:fg = [ '#EEEEEE', 255 ]
let s:black = [ '#30302c', 236 ]

let s:yellow = [ '#ffd75f', 221 ]
let s:magenta = [ '#afafd7', 103 ]
let s:blue = [ '#87afd7', 110 ]
let s:green = [ '#87AF87', 108 ]
let s:white = [ '#ffffff', 15 ]
let s:red = [ '#d75f5f', 167 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}, 'terminal':{}}

" Normal mode
let s:p.normal.left = [ [ s:black, s:blue ], [ s:white, s:black ] ]
let s:p.normal.right = [ [ s:fg, s:black ], [ s:fg, s:black ] ]
let s:p.normal.middle = [ [ s:fg, s:black ] ]

let s:p.inactive.right = [ [ s:fg, s:black ], [ s:fg, s:black ] ]
let s:p.inactive.left = copy(s:p.inactive.right)

" Other modes
let s:p.insert.left = [ [ s:black, s:red ], [ s:white, s:black ] ]
let s:p.replace.left = [ [ s:black, s:green ], [ s:white, s:black ] ]
let s:p.visual.left = [ [ s:black, s:yellow], [ s:white, s:black ] ]
let s:p.terminal.left = [ [ s:black, s:magenta], [ s:white, s:black ] ]

let s:p.inactive.middle = [ [ s:black, s:black ] ]

let s:p.tabline.left = [ [ s:fg, s:black ] ]
let s:p.tabline.tabsel = [ [ s:white, s:black ] ]
let s:p.tabline.middle = [ [ s:fg, s:black ] ]
let s:p.tabline.right = copy(s:p.tabline.middle)

let s:p.normal.error = [ [ s:red, s:black ] ]
let s:p.normal.warning = [ [ s:yellow, s:black ] ]

let g:lightline#colorscheme#hypnos256#palette = lightline#colorscheme#flatten(s:p)
