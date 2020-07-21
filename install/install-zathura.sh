#!/bin/bash

rm -rf $XDG_CONFIG_HOME/zathura
mkdir $XDG_CONFIG_HOME/zathura

ln -s $DOTFILES/zathura/zathurarc $XDG_CONFIG_HOME/zathura
