#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/doublecmd"
ln -sf "$DOTFILES/doublecmd/multiarc.ini" "$XDG_CONFIG_HOME/doublecmd/multiarc.ini"
ln -sf "$DOTFILES/doublecmd/session.ini" "$XDG_CONFIG_HOME/doublecmd/session.ini"
ln -sf "$DOTFILES/doublecmd/shortcuts.scf" "$XDG_CONFIG_HOME/doublecmd/shortcuts.scf"
