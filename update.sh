#!/usr/bin/env bash

source "$DOTFILES/colors.sh"
source "$DOTFILES/install_functions.sh"
source "$DOTFILES/install_config"

#---------------------------------------

# backup zsh history file
mkdir -p "$DOTFILES_CLOUD/zsh"
cp "$ZDOTDIR/.zhistory" "$DOTFILES_CLOUD/zsh/.zhistory-$(date +%F)"

#---------------------------------------

dot_mes_warn "Activate sudo"
sudo echo "Sudo activated!"

# dot_mes_update "npm packages"
# npm install -g npm
# npm update -g

dot_mes_update "composer packages"
sudo composer self-update
# cgr update

# dot_mes_update "composer packages"
# dot_install_func go update_go_binaries

#---------------------------------------

dot_mes_update "Neovim plugins"
nvim --noplugin +PlugUpdate +qa

#---------------------------------------

if hash yay 2>/dev/null; then
    yay -Syu
else
    sudo pacman -Syu
fi
