#!/bin/bash

rm $HOME/.zshrc &>/dev/null

ln -s -f $DOTFILES/zsh/zshrc $HOME/.zshrc

# From cloud
if [ -f "$DOTFILES_CLOUD/zsh/.zhistory" ];
then
    rm $HOME/.zhistory
    ln -sf $DOTFILES_CLOUD/zsh/.zhistory $HOME/
fi
