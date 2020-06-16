#!/bin/bash

rm $HOME/.zshrc &>/dev/null
rm $HOME/.zshenv &>/dev/null

ln -s -f $DOTFILES/zsh/zshenv $HOME/.zshenv
ln -s -f $DOTFILES/zsh/zshrc $HOME/.zshrc

# From cloud
if [ -f "$DOTFILES_CLOUD/zsh/.zhistory" ];
then
    rm $HOME/.zhistory
    ln -sf $DOTFILES_CLOUD/zsh/.zhistory $HOME/
fi
