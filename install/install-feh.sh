#!/bin/bash

rm $XDG_CONFIG_HOME/.fehbg &>/dev/null
ln -s $DOTFILES/feh/fehbg $XDG_CONFIG_HOME/.fehbg

