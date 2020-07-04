#!/bin/bash

rm $XDG_CONFIG_HOME/.Xresources &>/dev/null
ln -s $DOTFILES/xorg-server/Xresources $XDG_CONFIG_HOME/.Xresources

rm $HOME/.xinitrc &>/dev/null
ln -s $DOTFILES/xorg-server/xinitrc $HOME/.xinitrc

# monitor configs with arandr
rm -rf $XDG_CONFIG_HOME/config_monitors
ln -sf $DOTFILES_CLOUD/config_monitors $XDG_CONFIG_HOME/config_monitors
