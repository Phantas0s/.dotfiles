echo -e ""
echo -e "${red}Delete the mycli config..."
rm $HOME/.myclirc &>/dev/null
echo -e "${green}...done!"

echo -e "${blue} Installing mycli config..."
ln -s $DOTFILES/mycli/myclirc $HOME/.myclirc
echo -e "${green} ...done"
