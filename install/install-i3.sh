#!/bin/bash

##############
# install i3 #
##############

if [ ! -d $HOME/.i3 ]
  then
    mkdir $HOME/.i3
fi

ln -s $DOTFILES/i3/config /$HOME/.i3/config
ln -s $DOTFILES/i3/i3status.conf $HOME/.i3/i3status.conf
ln -s $DOTFILES/i3/scripts/ $HOME/.i3/scripts
