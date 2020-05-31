#!/bin/bash

rm -rf $I3_CONFIG &>/dev/null

if [ ! -d $I3_CONFIG/ ]
  then
    mkdir $I3_CONFIG/
fi

ln -s $DOTFILES/i3/lock.png $I3_CONFIG/lock.png
ln -s $DOTFILES/i3/config $I3_CONFIG/config
ln -s $DOTFILES/i3/scripts/ $I3_CONFIG/scripts

if [[ $I3_STATUS_BAR == "small" ]]; then
    ln -s $DOTFILES/i3/i3status-small.conf $I3_CONFIG/i3status.conf
else
    ln -s $DOTFILES/i3/i3status.conf $I3_CONFIG/i3status.conf
fi
