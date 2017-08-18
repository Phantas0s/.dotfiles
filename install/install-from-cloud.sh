#!/bin/bash

echo "${blue} installing private projects configuration from the cloud..."

if [[ -v DOTFILES_PROJECT_PATH ]]
then
    ln -sf $DOTFILES_PROJECT_PATH/tmuxinator $HOME/.tmuxinator
    # project relative configuration for neovim
    ln -sf $DOTFILES_PROJECT_PATH/projects.nvimrc $HOME/nvim/
    # monitor configs with arandr
    ln -sf $DOTFILES_PROJECT_PATH/config_monitors/ $HOME/
fi

if [[ -v DOTFILES_COMMON_PATH ]]
then
    ln -sf $DOTFILES_COMMON_PATH/perso_aliases $HOME/.perso_aliases
fi

echo ""
echo "${green} ...done"
