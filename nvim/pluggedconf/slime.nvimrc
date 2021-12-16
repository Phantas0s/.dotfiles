let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
" let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}

