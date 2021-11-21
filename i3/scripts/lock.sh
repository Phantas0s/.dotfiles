#!/usr/bin/env bash

# icon="$HOME/.i3/lock.png"
img=/tmp/i3lock.png

scrot -o $img
convert $img -scale 10% -scale 1000% $img

# Blur image
#convert $img -blur 0x4 500% $img
# convert $img $icon -gravity center -composite $img

i3lock -u -i $img
