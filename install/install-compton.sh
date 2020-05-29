#!/bin/bash
rm $HOME/.compton &>/dev/null
ln -s $DOTFILES/compton/compton $HOME/.compton
