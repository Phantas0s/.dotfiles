#!/bin/bash

if [ ! -d $HOME/vifm ]
  then
    mkdir $HOME/vifm
fi

rm -rf $HOME/vifm/vifmrc
ln -s $DOTFILES/vifm/vifmrc $HOME/vifm/vifmrc
