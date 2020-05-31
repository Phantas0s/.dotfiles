#!/bin/bash

# This script is called by i3 on startup.

# set the keyboard to mac
setxkbmap us mac

# maps caps lock to escape for vim (and ctrl)
setxkbmap -option 'caps:ctrl_modifier' && xcape -e 'Caps_Lock=Escape' &

xmodmap $XDG_HOME_CONFIG/.Xmodmap
