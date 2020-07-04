#!/bin/bash

rm -rf $XDG_CONFIG_HOME/X11
mkdir -p $XDG_CONFIG_HOME/X11

ln -s $DOTFILES/xorg-server/Xresources $XDG_CONFIG_HOME/X11/Xresources
ln -s $DOTFILES/xorg-server/xinitrc $XINITRC
ln -s $DOTFILES/xorg-server/Xmodmap $XDG_CONFIG_HOME/X11/Xmodmap
ln -s $DOTFILES/xorg-server/Xdefaults $XDG_CONFIG_HOME/X11/Xdefaults

# monitor configs with arandr
rm -rf $XDG_CONFIG_HOME/config_monitors
ln -sf $DOTFILES_CLOUD/config_monitors $XDG_CONFIG_HOME/config_monitors

