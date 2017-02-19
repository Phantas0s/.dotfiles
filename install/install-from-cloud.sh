#!/bin/bash

echo "${blue} installing personnal configuration from the cloud..."

if [[ -v DOTFILES_PROJECT_PATH ]]
then
    ln -s -f $DOTFILES_PROJECT_PATH/.tmuxinator $HOME/
    ln -s -f $DOTFILES_PROJECT_PATH/projects.nvimrc $HOME/nvim/
fi

echo "${green} ...done"
