#!/bin/bash

echo ""
echo "${blue}Installing Xorg config..."

ln -s $HOME/$ROOT_CONFIG/xorg-server/Xresources $HOME/.Xresources
ln -s $HOME/$ROOT_CONFIG/xorg-server/xinitrc $HOME/.xinitrc

echo "${green}...done"
