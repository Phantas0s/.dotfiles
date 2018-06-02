echo -e "${blue} Update npm packages..."

if [ ! -f $NPMBIN/eslint ];
then
    echo -e "${blue} Install esling..."
    npm i -g eslint
fi

echo -e "${green} ...done\n"

echo -e "${red}Delete ternjs config..."
rm $HOME/.tern-project &>/dev/null
echo -e "${green}...done!\n"

echo -e "${blue}Install ternjs config..."
ln -s ~/$ROOT_CONFIG/javascript/.tern-project ~/
echo -e "${green}...done!\n"
