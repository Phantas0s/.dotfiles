#!/bin/bash
# see https://github.com/ryanoasis/nerd-fonts#patched-fonts for many fonts

mkdir -p $XDG_DATA_HOME/fonts
cp -f $DOTFILES/fonts/* $XDG_DATA_HOME/fonts
