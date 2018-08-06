echo -e ""
echo -e "${red}Delete the pgcli config..."
rm $HOME/pgcli/config &>/dev/null
echo -e "${green}...done!"

echo -e "${blue} Installing pgcli config..."
mkdir -p $HOME/pgcli
ln -s $DOTFILES/pgcli/config $HOME/pgcli/config
echo -e "${green} ...done"
