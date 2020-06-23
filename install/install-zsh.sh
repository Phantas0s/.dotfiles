#!/bin/bash

rm $HOME/.zshrc &>/dev/null
rm -rf $ZDOTDIR &>/dev/null

mkdir $ZDOTDIR;

[ -f "$DOTFILES_CLOUD/zsh/.zhistory" ] && cp $DOTFILES_CLOUD/zsh/.zhistory $ZDOTDIR/.zhistory;

ln -s -f $DOTFILES/zsh/zshenv $HOME/.zshenv
ln -s -f $DOTFILES/zsh/zshrc $ZDOTDIR/.zshrc

