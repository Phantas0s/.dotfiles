if !exists('g:vdebug_options')
    let g:vdebug_options = {}
endif
let g:vdebug_options['break_on_open'] = 0
let g:vdebug_options['watch_window_style'] = 'compact'
let g:vdebug_options['port'] = 9003
let g:vdebug_keymap = {
\    'run' : '<F5>',
\    'run_to_cursor' : '<F9>',
\    'step_over' : '<F2>',
\    'step_into' : '<F3>',
\    'step_out' : '<F4>',
\    'close' : '<F6>',
\    'detach' : '<F7>',
\    'set_breakpoint' : '<F10>',
\    'get_context' : '<F11>',
\    'eval_under_cursor' : '<F12>',
\    'eval_visual' : '<F8>',
\}

" redefine the characters
autocmd php VimEnter * sign define breakpt text= texthl=DbgBreakptSign linehl=DbgBreakptLine
autocmd php VimEnter * sign define current text= texthl=DbgCurrentSign linehl=DbgCurrentLine

" map the project when used in a vagrant / vm | vm path : host past
let g:vdebug_options['path_maps'] = {
     \       '/opt/medical-visit': '/home/hypnos/workspace/fernarzt/fernarzt-medical-visit',
\}
