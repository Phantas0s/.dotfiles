#!/usr/bin/env bash

# Copy the default config file if not present already

############
# includes #
############

[ ! -f install_config ] && cp install_config.dist install_config

source ./install_config
source ./colors.sh
source ./install_functions.sh
source ./zsh/zshenv

################
# presentation #
################

echo -e "
${yellow}
          _ ._  _ , _ ._
        (_ ' ( \`  )_  .__)
      ( (  (    )   \`)  ) _)
     (__ (_   (_ . _) _) ,__)
           ~~\ ' . /~~
         ,::: ;   ; :::,
        ':::::::::::::::'
 ____________/_ __ \____________
|                               |
| Welcome to Phantas0s dotfiles |
|_______________________________|
"

echo -e "${yellow}!!! ${red}WARNING${yellow} !!!"
echo -e "${light_red}This script will delete all your configuration files!"
echo -e "${light_red}Use it at your own risks."

if [ $# -ne 1 ] || [ "$1" != "-y" ];
    then
        echo -e "${yellow}Press a key to continue...\n"
        read key;
fi

###########
# INSTALL #
###########

# Install
. "$DOTFILES/install/install-zsh.sh"
. "$DOTFILES/install/install-from-cloud.sh"
. "$DOTFILES/install/install-fonts.sh"
. "$DOTFILES/install/install-X11.sh"

dot_is_installed git && dot_install projects
dot_is_installed lxappearance && dot_install theme
dot_is_installed i3 && dot_install i3
dot_is_installed git && dot_install git
dot_is_installed nvim && dot_install nvim
dot_is_installed tmux && dot_install tmux
dot_is_installed dunst && dot_install dunst
dot_is_installed feh && dot_install feh
dot_is_installed mycli && dot_install mycli
dot_is_installed pgcli && dot_install pgcli
dot_is_installed joplin && dot_install joplin
dot_is_installed vifm && dot_install vifm
dot_is_installed clojure && dot_install clojure dot_is_installed freemind && dot_install freemind
dot_is_installed redshift && dot_install redshift
dot_is_installed gimp && dot_install gimp
dot_is_installed zathura && dot_install zathura
dot_is_installed doublecmd && dot_install doublecmd
dot_is_installed deadbeef && dot_install deadbeef
dot_is_installed darktable && dot_install darktable
dot_is_installed digikam && dot_install digikam
dot_is_installed newsboat && dot_install newsboat
dot_is_installed taskell && dot_install taskell
dot_is_installed devdash && dot_install devdash
dot_is_installed php && dot_install php
dot_is_installed kitty && dot_install kitty
dot_is_installed sxiv && dot_install sxiv
dot_is_installed litecli && dot_install litecli
dot_is_installed thunderbird && dot_install thunderbird

dot_install gtk
# dot_install default-app
