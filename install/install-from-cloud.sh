#!/bin/bash


if [ ! -z "$DOTFILES_CLOUD" ];
then
    echo -e "${blue} installing private projects configuration from the cloud..."

    #tmuxp projects
    ln -sf $DOTFILES_CLOUD/tmuxp/ $HOME/.tmuxp

    # project relative configuration for neovim
    ln -sf $DOTFILES_CLOUD/projects.nvimrc $HOME/nvim/

    # monitor configs with arandr
    ln -sf $DOTFILES_CLOUD/config_monitors/ $HOME/

    if [ -d "$DOTFILES_CLOUD/openssh" ];
    then
        if [ ! -d "$HOME/.ssh" ];
        then
            mkdir $HOME/.ssh > /dev/null
        fi

        echo -e ""
        echo -e "${red}Delete the git config..."
        rm $HOME/.gitconfig &>/dev/null
        echo -e "${green}...done!"

        echo -e ""
        echo -e "${blue} Installing ssh config from the cloud"
        cp $DOTFILES_CLOUD/openssh/config $HOME/.ssh/config
        chown $USER:$USER $HOME/.ssh/config
        chmod 700 $HOME/.ssh/config
        echo -e "${green} ...done"
    fi

        echo -e "${green} ...done"
fi

if [ ! -z "$WALLPAPER_PATH" ]
then
    echo -e "${blue} Installing wallpapers from the cloud..."
    ln -s $WALLPAPER_PATH ~/wallpapers
    echo -e "${green} ...done"
fi
