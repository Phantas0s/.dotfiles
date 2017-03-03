#!/bin/bash

echo "${blue} installing private projects configuration from the cloud..."

if [[ -v DOTFILES_PROJECT_PATH ]]
then
    ln -s -f $DOTFILES_PROJECT_PATH/tmuxinator $HOME/.tmuxinator
    # project relative configuration for neovim
    ln -s -f $DOTFILES_PROJECT_PATH/projects.nvimrc $HOME/nvim/
fi

echo ""
echo "${green} ...done"
