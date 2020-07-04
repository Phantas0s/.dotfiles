#!/bin/bash
# see https://github.com/ryanoasis/nerd-fonts#patched-fonts for many fonts

if [ ! -d $XDG_DATA_HOME/fonts ]
  then
    mkdir $XDG_DATA_HOME/fonts
fi

cp -f $DOTFILES/fonts/* $XDG_DATA_HOME/fonts
