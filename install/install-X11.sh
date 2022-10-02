#!/usr/bin/env bash

mkdir -p "$XDG_CONFIG_HOME/X11"

ln -sf "$DOTFILES/X11/xresources" "$XDG_CONFIG_HOME/X11/xresources"
ln -sf "$DOTFILES/X11/xinitrc" "$XINITRC"
ln -sf "$DOTFILES/X11/xmodmap" "$XDG_CONFIG_HOME/X11/xmodmap"

# monitor configs with arandr
ln -sf "$DOTFILES_CLOUD/config_monitors" "$XDG_CONFIG_HOME/config_monitors"
