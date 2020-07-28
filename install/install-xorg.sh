#!/bin/bash

rm -rf $XDG_CONFIG_HOME/xorg
mkdir -p $XDG_CONFIG_HOME/xorg

ln -s $DOTFILES/xorg/xresources $XDG_CONFIG_HOME/xorg/xresources
ln -s $DOTFILES/xorg/xinitrc $XINITRC
ln -s $DOTFILES/xorg/xmodmap $XDG_CONFIG_HOME/xorg/xmodmap

# monitor configs with arandr
rm -rf $XDG_CONFIG_HOME/config_monitors
ln -sf $DOTFILES_CLOUD/config_monitors $XDG_CONFIG_HOME/config_monitors

