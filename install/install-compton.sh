#!/bin/bash
rm $XDG_CONFIG_HOME/.compton &>/dev/null
ln -s $DOTFILES/compton/compton $XDG_CONFIG_HOME/.compton
