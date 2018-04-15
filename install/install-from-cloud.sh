#!/bin/bash


if [ ! -z "$DOTFILES_PROJECT_PATH" ];
then
    echo -e "${blue} installing private projects configuration from the cloud..."

    #tmuxinator projects - to get rid of
    ln -sf $DOTFILES_PROJECT_PATH/tmuxinator $HOME/.tmuxinator
    #tmuxp projects
    ln -sf $DOTFILES_PROJECT_PATH/tmuxp $HOME/.tmuxp

    # project relative configuration for neovim
    ln -sf $DOTFILES_PROJECT_PATH/projects.nvimrc $HOME/nvim/

    # monitor configs with arandr
    ln -sf $DOTFILES_PROJECT_PATH/config_monitors/ $HOME/

    echo -e "${green} ...done"
fi

if [ ! -z "$DOTFILES_COMMON_PATH" ];
then
    echo -e "${blue} Installing personnal aliases from the cloud..."
    ln -sf $DOTFILES_COMMON_PATH/perso_aliases $HOME/.perso_aliases
    echo -e "${green} ...done"
fi

if [ ! -z "$WALLPAPER_PATH" ]
then
    echo -e "${blue} Installing wallpapers from the cloud..."
    ln -s $WALLPAPER_PATH ~/wallpapers
    echo -e "${green} ...done"
fi
