#!/bin/bash
# see https://github.com/ryanoasis/nerd-fonts#patched-fonts for a lot of fonts

if [ ! -d $HOME/.fonts ]
  then
    mkdir $HOME/.fonts
fi

cp -f $DOTFILES/fonts/* $HOME/.fonts
