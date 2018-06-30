#!/bin/bash

echo -e "${blue}Installing Xorg config..."

ln -s $DOTFILES/xorg-server/Xresources $HOME/.Xresources
ln -s $DOTFILES/xorg-server/xinitrc $HOME/.xinitrc

echo -e "${green}...done"
