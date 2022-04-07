#!/usr/bin/env bash

mkdir -p "$XDG_CONFIG_HOME/git"

ln -sf "$DOTFILES/git/gitconfig" "$XDG_CONFIG_HOME/git/config"
ln -sf "$DOTFILES/git/gitignore" "$XDG_CONFIG_HOME/git/ignore"

# Set the global hooks
# DEACTIVATED - Mess up stuff when rebasing
# Should be added manually
# git config --global init.templatedir "$DOTFILES/git/templates"
