#!/usr/bin/env bash

mkdir -p $I3_CONFIG/

ln -sf $DOTFILES/i3/lock.png $I3_CONFIG
ln -sf $DOTFILES/i3/config $I3_CONFIG
ln -sf $DOTFILES/i3/scripts $I3_CONFIG

if [[ $I3_STATUS_BAR == "small" ]]; then
    ln -sf $DOTFILES/i3/i3status-small.conf $I3_CONFIG/i3status.conf
else
    ln -sf $DOTFILES/i3/i3status.conf $I3_CONFIG
fi
