#!/bin/bash
# Copy the default config file if not present already
############
# includes #
############

if [ ! -f ./install_config ];
then
    cp ./install_config.diff ./install_config
fi

. ./env
. ./install_config
. $HOME/$ROOT_CONFIG/colors

################
# presentation #
################

#!/bin/bash
echo -e "${green}####################################"
echo -e "${green}# Welcome to Phantas0s's dotfiles! #"
echo -e "${green}####################################\n"

echo -e "${yellow}!!! ${red}WARNING${yellow} !!!"
echo -e "${light_red}This script will delete all your configuration!"
echo -e "${light_red}Use it for a fresh install or if you only use this set of dotfiles.\n"

if [ $# -ne 1 ] || [ "$1" != "-y" ];
    then
        echo -e "${yellow}Press a key to continue...\n"
        read key;
fi

###########
# INSTALL #
###########

# Uninstall everything
# TODO: let the choice to backup :D

. $HOME/$ROOT_CONFIG/uninstall.sh

# Install
. $HOME/$ROOT_CONFIG/install/install-from-cloud.sh
. $HOME/$ROOT_CONFIG/install/install-fonts.sh
. $HOME/$ROOT_CONFIG/install/install-prezto.sh
. $HOME/$ROOT_CONFIG/install/install-xorg-server.sh

command -v "lxappearance" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-theme.sh
command -v "i3" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-i3.sh
command -v "urxvt" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-urxvt.sh
command -v "git" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-git.sh
command -v "nvim" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-nvim.sh
command -v "tmux" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-tmux.sh
command -v "dunst" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-dunst.sh
command -v "feh" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-feh.sh
command -v "jrnl" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-jrnl.sh
command -v "composer" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-composer.sh
command -v "mycli" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-mycli.sh
command -v "ranger" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-ranger.sh
command -v "go" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-go.sh
command -v "ssh-keygen" >/dev/null && . $HOME/$ROOT_CONFIG/install/install-projects.sh

echo -e "${blue}Create symlinks for .bashrc config..."
ln -s $HOME/$ROOT_CONFIG/bash/bashrc $HOME/.bashrc
echo -e "${green} ...done\n"

echo -e "${blue}Create symlinks for Xmodmap key mapping...."
ln -s $HOME/$ROOT_CONFIG/xorg-server/Xmodmap $HOME/.Xmodmap
echo -e "${green} ...done\n"

# Source startup
source $HOME/$ROOT_CONFIG/startup
