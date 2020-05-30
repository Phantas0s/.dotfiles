#!/bin/bash

rm -rf $XDG_CONFIG_HOME/i3/ &>/dev/null
rm -rf $XDG_CONFIG_HOME/.i3/ &>/dev/null

if [ ! -d $XDG_CONFIG_HOME/.i3 ]
  then
    mkdir $XDG_CONFIG_HOME/.i3
fi

ln -s $DOTFILES/i3/lock.png /$XDG_CONFIG_HOME/.i3/lock.png
ln -s $DOTFILES/i3/config /$XDG_CONFIG_HOME/.i3/config
ln -s $DOTFILES/i3/scripts/ $XDG_CONFIG_HOME/.i3/scripts

if [[ $I3_STATUS_BAR == "small" ]]; then
    ln -s $DOTFILES/i3/i3status-small.conf $XDG_CONFIG_HOME/.i3/i3status.conf
else
    ln -s $DOTFILES/i3/i3status.conf $XDG_CONFIG_HOME/.i3/i3status.conf
fi
