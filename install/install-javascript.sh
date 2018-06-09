echo -e "${red}Delete the javascript config..."
rm $HOME/.tern-project &>/dev/null
rm $HOME/.eslintrc.json &>/dev/null
echo -e "${green}...done!\n"

ln -s ~/$ROOT_CONFIG/javascript/.tern-project ~/
ln -s ~/$ROOT_CONFIG/javascript/.eslintrc.json ~/
