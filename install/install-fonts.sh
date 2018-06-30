#!/bin/bash
# see https://github.com/ryanoasis/nerd-fonts#patched-fonts for a lot of fonts

echo ""
echo "${blue}Install the fonts..."

if [ ! -d $HOME/.fonts ]
  then
    mkdir $HOME/.fonts
fi

cp -f $DOTFILES/fonts/* $HOME/.fonts

echo "${green} ...done"

