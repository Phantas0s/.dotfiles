echo -e "${red}Delete the javascript config..."
rm $HOME/.tern-project &>/dev/null
rm $HOME/.eslintrc.json &>/dev/null
echo -e "${green}...done!\n"

ln -s ~/$ROOT_CONFIG/javascript/.tern-project ~/
ln -s ~/$ROOT_CONFIG/javascript/.eslintrc.json ~/

echo -e "${red}Install javascript linters..."
# Works better than eslint for React
if [ ! -d ~/.node_modules/lib/node_modules/babel-eslint ];
then
    npm i -g babel-eslint
fi

if [ ! -f ~/.node_modules/bin/eslint ];
then
   npm i -g eslint
fi

echo -e "${green}...done!\n"
