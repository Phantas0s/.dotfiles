echo -e ""
echo -e "${red}Delete compton config..."
rm $HOME/.compton &>/dev/null
echo -e "${green}...done!"

echo -e "${blue} Installing compton config..."
ln -s $DOTFILES/compton/compton $HOME/.compton
echo -e "${green} ...done"
