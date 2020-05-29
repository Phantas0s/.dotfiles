#!/bin/bash
rm $HOME/.dunstrc &>/dev/null
rm -rf $HOME/.testomatic &>/dev/null

ln -s $DOTFILES/dunst/dunstrc $HOME/.dunstrc
ln -s $DOTFILES/dunst/testomatic $HOME/.testomatic

