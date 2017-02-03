#!/bin/bash
# see https://github.com/ryanoasis/nerd-fonts#patched-fonts for a lot of fonts

echo ""
echo "${blue}Install the fonts..."

if [ ! -d $HOME/.fonts ]
  then
    mkdir $HOME/.fonts
fi

cp -f $HOME/$ROOT_CONFIG/fonts/* $HOME/.fonts

echo "${green} ...done"

