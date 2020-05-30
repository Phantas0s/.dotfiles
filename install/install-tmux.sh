#!/bin/bash

rm $XDG_CONFIG_HOME/.tmux.conf &>/dev/null
rm $XDG_CONFIG_HOME/.tmux.conf &>/dev/null
ln -s $DOTFILES/tmux/tmux.conf $XDG_CONFIG_HOME/.tmux.conf

if [ ! -d $XDG_CONFIG_HOME/.tmux ]
  then
    mkdir $XDG_CONFIG_HOME/.tmux
    git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/.tmux/plugins/tpm
    $XDG_CONFIG_HOME/.tmux/plugins/tpm/bin/install_plugins
fi

if [ ! -d $XDG_CONFIG_HOME/.tmux/plugins/tpm ]
then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
