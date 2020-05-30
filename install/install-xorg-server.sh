#!/bin/bash

rm $XDG_CONFIG_HOME/.Xresources &>/dev/null
ln -s $DOTFILES/xorg-server/Xresources $XDG_CONFIG_HOME/.Xresources
rm $XDG_CONFIG_HOME/.xinitrc &>/dev/null
ln -s $DOTFILES/xorg-server/xinitrc $XDG_CONFIG_HOME/.xinitrc
