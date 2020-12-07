#!/bin/bash

rm -rf ~/.config/lutris
ln -sf "$DOTFILES/lutris" "$XDG_CONFIG_HOME"
