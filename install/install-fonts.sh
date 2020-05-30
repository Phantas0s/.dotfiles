#!/bin/bash
# see https://github.com/ryanoasis/nerd-fonts#patched-fonts for a lot of fonts

if [ ! -d $XDG_CONFIG_HOME/.fonts ]
  then
    mkdir $XDG_CONFIG_HOME/.fonts
fi

cp -f $DOTFILES/fonts/* $XDG_CONFIG_HOME/.fonts
