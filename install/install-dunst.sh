#!/usr/bin/env bash

mkdir -p $XDG_CONFIG_HOME/dunst
ln -sf $DOTFILES/dunst/dunstrc $XDG_CONFIG_HOME/dunst/dunstrc
ln -sf $DOTFILES/testomatic $XDG_CONFIG_HOME/.testomatic
