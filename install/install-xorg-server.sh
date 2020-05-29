#!/bin/bash

rm $HOME/.Xresources &>/dev/null
ln -s $DOTFILES/xorg-server/Xresources $HOME/.Xresources
rm $HOME/.xinitrc &>/dev/null
ln -s $DOTFILES/xorg-server/xinitrc $HOME/.xinitrc
