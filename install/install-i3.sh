#!/bin/bash

##############
# install i3 #
##############

if [ ! -d $HOME/.i3 ]
  then 
    mkdir $HOME/.i3
fi

ln -s $HOME/$ROOT_CONFIG/i3/config /$HOME/.i3/config
ln -s $HOME/$ROOT_CONFIG/i3/i3status.conf $HOME/.i3/i3status.conf
ln -s $HOME/$ROOT_CONFIG/i3/scripts/ $HOME/.i3/scripts
