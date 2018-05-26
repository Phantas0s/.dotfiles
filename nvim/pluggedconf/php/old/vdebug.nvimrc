" Might conflict with delve for Go
" vdebug

let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000
let g:vdebug_keymap = {
\    "run" : "<leader><F5>",
\    "run_to_cursor" : "<leader><F9>",
\    "step_over" : "<leader><F2>",
\    "step_into" : "<leader><F3>",
\    "step_out" : "<leader><F4>",
\    "close" : "<leader><F6>",
\    "detach" : "<leader><F7>",
\    "set_breakpoint" : "<leader><F10>",
\    "get_context" : "<leader><F11>",
\    "eval_under_cursor" : "<leader><F12>",
\    "eval_visual" : "<leader><F8>",
\}

" redefine the characters
autocmd vimrc VimEnter * sign define breakpt text= texthl=DbgBreakptSign linehl=DbgBreakptLine
autocmd vimrc VimEnter * sign define current text= texthl=DbgCurrentSign linehl=DbgCurrentLine

" map the project when used in a vagrant / vm | vm path : host past
" let g:vdebug_options["path_maps"] = {
  \}

