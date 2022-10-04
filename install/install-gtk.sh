#!/usr/bin/env bash

# For more icons and themes, see:
# https://www.gnome-look.org/
# https://aur.archlinux.org/packages.php?O=0&L=0&C=17&K=icon-theme&SeB=nd&SB=n&SO=a&PP=50&do_Search=Go
# https://wiki.archlinux.org/index.php/GTK

mkdir -p "$HOME/.icons"

if [ ! -d "$HOME/.icons/Flatery-Yellow" ]; then
    rm -rf /tmp/Flatery
    git clone https://github.com/Phantas0s/Flatery /tmp/Flatery
    mv /tmp/Flatery/Flatery-Yellow "$HOME/.icons"
fi
