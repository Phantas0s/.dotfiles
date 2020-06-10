rm $XDG_CONFIG_HOME/.Xdefaults &>/dev/null
ln -s $DOTFILES/urxvt/Xdefaults $XDG_CONFIG_HOME/.Xdefaults

rm $XDG_CONFIG_HOME/.dircolors
ln -s $DOTFILES/urxvt/dircolors $XDG_CONFIG_HOME/.dircolors
