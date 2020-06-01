#!/bin/bash

# This script is called by i3 on startup.
# Might be not necessary anymore (see xinitrc)

# set the keyboard to mac
setxkbmap us mac

# maps caps lock to escape for vim (and ctrl)
setxkbmap -option 'caps:ctrl_modifier' && xcape -e 'Caps_Lock=Escape' &

xmodmap $XDG_CONFIG_HOME/.Xmodmap
