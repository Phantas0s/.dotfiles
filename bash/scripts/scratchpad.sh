#!/usr/bin/env bash

# Terminal scratchpad with tmux and three windows:
# 1.term
# 2.vim (on a temp file)
# 3.translation CLI
# Used to restart i3 scratchpad if it was closed; logic is duplicated in i3/config

tmux kill-session -t scratchpad 2> /dev/null
urxvtc -name urxvt_scratchpad -e tmux new-session -d -s scratchpad ';' \
    attach-session -d -t scratchpad ';' \
    new-window -n nvim 'nvim +e /tmp/scratchpad.md +"set spelllang=de,en"' ';' \
    new-window -n trans 'trans -I' ';' \
    new-window -n mixer 'pulsemixer' ';'
