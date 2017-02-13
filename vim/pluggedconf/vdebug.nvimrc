" vdebug

let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000
let g:vdebug_keymap = {
\    "run" : "<F5>",
\    "run_to_cursor" : "<F9>",
\    "step_over" : "<F2>",
\    "step_into" : "<F3>",
\    "step_out" : "<F4>",
\    "close" : "<F6>",
\    "detach" : "<F7>",
\    "set_breakpoint" : "<F10>",
\    "get_context" : "<F11>",
\    "eval_under_cursor" : "<F12>",
\    "eval_visual" : "<F8>",
\}

" map the project when used in a vagrant / vm | vm path : host past
let g:vdebug_options["path_maps"] = {
\}
