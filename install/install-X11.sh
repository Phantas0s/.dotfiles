#!/bin/bash

rm -rf $XDG_CONFIG_HOME/X11
mkdir -p $XDG_CONFIG_HOME/X11

ln -s $DOTFILES/X11/xresources $XDG_CONFIG_HOME/X11/xresources
ln -s $DOTFILES/X11/xinitrc $XINITRC
ln -s $DOTFILES/X11/xmodmap $XDG_CONFIG_HOME/X11/xmodmap

# monitor configs with arandr
rm -rf $XDG_CONFIG_HOME/config_monitors
ln -sf $DOTFILES_CLOUD/config_monitors $XDG_CONFIG_HOME/config_monitors

