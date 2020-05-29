#!/bin/bash

rm -rf $HOME/.config/i3/ &>/dev/null
rm -rf $HOME/.i3 &>/dev/null

if [ ! -d $HOME/.i3 ]
  then
    mkdir $HOME/.i3
fi

ln -s $DOTFILES/i3/lock.png /$HOME/.i3/lock.png
ln -s $DOTFILES/i3/config /$HOME/.i3/config
ln -s $DOTFILES/i3/scripts/ $HOME/.i3/scripts

if [[ $I3_STATUS_BAR == "small" ]]; then
    ln -s $DOTFILES/i3/i3status-small.conf $HOME/.i3/i3status.conf
else
    ln -s $DOTFILES/i3/i3status.conf $HOME/.i3/i3status.conf
fi
