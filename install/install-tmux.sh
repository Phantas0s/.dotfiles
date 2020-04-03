#!/bin/bash

echo ""
echo "${blue}Install tmux config..."

ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf



if [ ! -d $HOME/.tmux ]
  then
    mkdir $HOME/.tmux
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    $HOME/.tmux/plugins/tpm/bin/install_plugins
fi

if [ ! -d $HOME/.tmux/plugins/tmp ]
then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "${green} ...done"

