#!/bin/bash

#TODO separate all of that

rm $XDG_CONFIG_HOME/.tmuxp &>/dev/null

if [ ! -z "$DOTFILES_CLOUD" ];
then
    #tmuxp projects
    ln -sf $DOTFILES_CLOUD/tmuxp/ $XDG_CONFIG_HOME/.tmuxp

    # project relative configuration for neovim
    ln -sf $DOTFILES_CLOUD/projects.nvimrc $XDG_CONFIG_HOME/nvim/

    # monitor configs with arandr
    ln -sf $DOTFILES_CLOUD/config_monitors/ $XDG_CONFIG_HOME/

    if [ -f "$DOTFILES_CLOUD/zsh/.zhistory" ];
    then
        rm $HOME/.zhistory
        ln -sf $DOTFILES_CLOUD/zsh/.zhistory $HOME/
    fi

    if [ -d "$DOTFILES_CLOUD/openssh" ];
    then
        if [ ! -d "$HOME/.ssh" ];
        then
            mkdir $HOME/.ssh > /dev/null
        fi

        rm $HOME/.ssh/config &>/dev/null

        cp $DOTFILES_CLOUD/openssh/config $HOME/.ssh/config
        # chown $USER:$USER $HOME/.ssh/config
        chmod 700 $HOME/.ssh/config
    fi
fi

rm -rf $HOME/wallpapers

if [ ! -z "$WALLPAPER_PATH" ]
then
    ln -s $WALLPAPER_PATH ~/wallpapers
fi

if [ ! -z "$CLOUD" ];
then
    # vpn config
    rm $XDG_CONFIG_HOME/vpn/ &>/dev/null
    ln -sf $CLOUD/vpn $XDG_CONFIG_HOME/.vpn
fi
