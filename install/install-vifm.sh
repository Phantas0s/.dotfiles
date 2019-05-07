#!/bin/bash

echo ""
echo "${blue}Install tmux config..."



if [ ! -d $HOME/vifm ]
  then
    mkdir $HOME/vifm
fi

rm -rf $HOME/vifm/vifmrc
ln -s $DOTFILES/vifm/vifmrc $HOME/vifm/vifmrc

echo "${green} ...done"

