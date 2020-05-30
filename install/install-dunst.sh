#!/bin/bash
rm $XDG_CONFIG_HOME/.dunstrc &>/dev/null
rm -rf $XDG_CONFIG_HOME/.testomatic &>/dev/null

ln -s $DOTFILES/dunst/dunstrc $XDG_CONFIG_HOME/.dunstrc
ln -s $DOTFILES/dunst/testomatic $XDG_CONFIG_HOME/.testomatic

