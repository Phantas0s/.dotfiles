let g:vimspector_install_gadgets = [ 'vscode-php-debug' ]

nmap <f2> <Plug>VimspectorStepOver
nmap <f3> <Plug>VimspectorStepInto
nmap <f4> <Plug>VimspectorStepOut
nmap <f5> <Plug>VimspectorContinue " Start debugging or continue
nmap <f6> <Plug>VimspectorStop
nmap <f7> <Plug>VimpectorRestart
nmap <f10> <Plug>VimspectorToggleBreakpoint
" nmap <f11> <Plug>VimspectorBalloonEval
nmap <f11> :call vimspector#ClearBreakpoints()<cr>
nmap <f12> :VimspectorReset<cr>

let g:vimspector_sign_priority = {
  \    'vimspectorBP':         999,
  \    'vimspectorBPCond':     999,
  \    'vimspectorBPDisabled': 999,
  \    'vimspectorPC':         999,
  \ }
