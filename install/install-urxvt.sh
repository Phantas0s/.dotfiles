echo -e "${blue} Installing urxvt config..."
ln -s $DOTFILES/urxvt/Xdefaults $HOME/.Xdefaults
ln -s $DOTFILES/urxvt/dircolors $HOME/.dircolors
rm -rf $HOME/.urxvt/tabbed

if [ ! -d $HOME/.urxvt ]
  then
    mkdir $HOME/.urxvt
fi

ln -sf $DOTFILES/urxvt/extensions/tabbed $HOME/.urxvt/tabbed
echo -e "${green} ...done"
