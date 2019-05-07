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
. $DOTFILES/colors

################
# presentation #
################

#!/bin/bash

echo -e "
${yellow}
          _ ._  _ , _ ._
        (_ ' ( \`  )_  .__)
      ( (  (    )   \`)  ) _)
     (__ (_   (_ . _) _) ,__)
         `~~`\ ' . /`~~`
         ,::: ;   ; :::,
        ':::::::::::::::'
 ____________/_ __ \____________
|                               |
| Welcome to Phantas0s dotfiles |
|_______________________________|
"

echo -e "${yellow}!!! ${red}WARNING${yellow} !!!"
echo -e "${light_red}This script will delete all your configuration fils!"
echo -e "${light_red}Use it at your own risks."

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

. $DOTFILES/uninstall.sh

# Install
. $DOTFILES/install/install-from-cloud.sh
. $DOTFILES/install/install-fonts.sh
. $DOTFILES/install/install-prezto.sh
. $DOTFILES/install/install-xorg-server.sh

command -v "ssh-keygen" >/dev/null && command -v "git" >/dev/null && . $DOTFILES/install/install-projects.sh
command -v "lxappearance" >/dev/null && . $DOTFILES/install/install-theme.sh
command -v "i3" >/dev/null && . $DOTFILES/install/install-i3.sh
command -v "urxvt" >/dev/null && . $DOTFILES/install/install-urxvt.sh
command -v "git" >/dev/null && . $DOTFILES/install/install-git.sh
command -v "nvim" >/dev/null && . $DOTFILES/install/install-nvim.sh
command -v "tmux" >/dev/null && . $DOTFILES/install/install-tmux.sh
command -v "dunst" >/dev/null && . $DOTFILES/install/install-dunst.sh
command -v "feh" >/dev/null && . $DOTFILES/install/install-feh.sh
command -v "fzf" >/dev/null && . $DOTFILES/install/install-fzf.sh
command -v "jrnl" >/dev/null && . $DOTFILES/install/install-jrnl.sh
command -v "composer" >/dev/null && . $DOTFILES/install/install-composer.sh
command -v "mycli" >/dev/null && . $DOTFILES/install/install-mycli.sh
command -v "pgcli" >/dev/null && . $DOTFILES/install/install-pgcli.sh
command -v "ranger" >/dev/null && . $DOTFILES/install/install-ranger.sh
command -v "go" >/dev/null && . $DOTFILES/install/install-go.sh
command -v "npm" >/dev/null && . $DOTFILES/install/install-javascript.sh
command -v "compton" >/dev/null && . $DOTFILES/install/install-compton.sh
command -v "bat" >/dev/null && . $DOTFILES/install/install-bat.sh
command -v "joplin" >/dev/null && . $DOTFILES/install/install-joplin.sh
command -v "vifm" >/dev/null && . $DOTFILES/install/install-vifm.sh

echo -e "${blue}Create symlinks for .bashrc config..."
ln -s $DOTFILES/bash/bashrc $HOME/.bashrc
echo -e "${green} ...done\n"

echo -e "${blue}Create symlinks for Xmodmap key mapping...."
ln -s $DOTFILES/xorg-server/Xmodmap $HOME/.Xmodmap
echo -e "${green} ...done\n"

# Source startup
source $DOTFILES/startup
