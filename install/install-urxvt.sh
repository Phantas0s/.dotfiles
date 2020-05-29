rm $HOME/.Xdefaults &>/dev/null
ln -s $DOTFILES/urxvt/Xdefaults $HOME/.Xdefaults
rm $HOME/.dircolors
ln -s $DOTFILES/urxvt/dircolors $HOME/.dircolors
