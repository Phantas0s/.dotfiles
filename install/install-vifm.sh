#!/bin/bash

if [ ! -d $XDG_CONFIG_HOME/vifm ]
  then
    mkdir $XDG_CONFIG_HOME/vifm
fi

rm -rf $XDG_CONFIG_HOME/vifm/vifmrc
ln -s $DOTFILES/vifm/vifmrc $XDG_CONFIG_HOME/vifm/vifmrc
