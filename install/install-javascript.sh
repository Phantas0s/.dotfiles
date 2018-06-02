echo -e ""
echo -e "${red}Delete ternjs config..."
rm $HOME/.tern-project &>/dev/null
echo -e "${green}...done!"

ln -s ~/$ROOT_CONFIG/javascript/.tern-project ~/
