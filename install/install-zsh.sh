#!/usr/bin/env bash

mkdir -p $ZDOTDIR;

[ -f "$DOTFILES_CLOUD/zsh/.zhistory" ] && cp $DOTFILES_CLOUD/zsh/.zhistory $ZDOTDIR/.zhistory;

ln -sf $DOTFILES/zsh/zshenv $HOME/.zshenv
ln -sf $DOTFILES/zsh/zshrc $ZDOTDIR/.zshrc

ln -sf $DOTFILES/zsh/dircolors $ZDOTDIR/dircolors

