#!/usr/bin/env bash

#TODO separate all of that
#TODO from cloud shouldn't exist

rm "$XDG_CONFIG_HOME/.tmuxp" &>/dev/null

if [ -n "$DOTFILES_CLOUD" ];
then
    # project relative configuration for neovim
    ln -sf "$DOTFILES_CLOUD/projects.nvimrc" "$VIMCONFIG"

    # monitor configs with arandr
    ln -sf "$DOTFILES_CLOUD/config_monitors" "$XDG_CONFIG_HOME"

    if [ -d "$DOTFILES_CLOUD/openssh" ];
    then
        if [ ! -d "$HOME/.ssh" ];
        then
            mkdir "$HOME/.ssh" > /dev/null
        fi

        rm "$HOME/.ssh/config" &>/dev/null

        cp "$DOTFILES_CLOUD/openssh/config" "$HOME/.ssh/config"
        chmod 700 "$HOME/.ssh/config"
    fi
fi

rm -rf "$HOME/wallpapers"

if [ -n "$WALLPAPER_PATH" ]
then
    ln -s "$WALLPAPER_PATH" ~/wallpapers
fi

if [ -n "$CLOUD" ];
then
    # vpn config
    rm "$XDG_CONFIG_HOME/vpn/" &>/dev/null
    ln -sf "$CLOUD/vpn" "$XDG_CONFIG_HOME/.vpn"
fi
