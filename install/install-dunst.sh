echo ""
echo "${blue}Install dunst..."

ln -s $DOTFILES/dunst/dunstrc $HOME/.dunstrc

# Useful for autotest.rb
ln -s $DOTFILES/dunst/testomatic $HOME/.testomatic

echo "${green} ...done"

