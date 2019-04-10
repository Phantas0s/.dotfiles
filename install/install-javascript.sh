#!/bin/bash

echo -e "${red}Delete the javascript config..."
rm $HOME/.tern-project &>/dev/null
rm $HOME/.eslintrc.json &>/dev/null
echo -e "${green}...done!\n"


echo -e "${blue}Install javascript linters..."
# Works better than eslint for React
if [ ! -d $HOME/.node_modules/lib/node_modules/babel-eslint ];
then
    npm i -g babel-eslint
fi

if [ ! -d $HOME/.node_modules/lib/node_modules/eslint-plugin-html ];
then
    npm i -g eslint-plugin-html
fi

if [ ! -f $HOME/.node_modules/bin/eslint ];
then
   npm i -g eslint
fi

ln -s $DOTFILES/javascript/.tern-project $HOME
ln -s $DOTFILES/javascript/.eslintrc.json $HOME
echo -e "${green}...done!\n"

echo -e "${blue}Install typescript tools..."
if [ ! -d $HOME/.node_modules/lib/node_modules/neovim ];
then
    npm i -g neovim
fi

if [ ! -d $HOME/.node_modules/lib/node_modules/typescript ];
then
    npm i -g typescript
fi

if [ ! -d $HOME/.node_modules/lib/node_modules/bash-language-server ];
then
    npm i -g bash-language-server
fi

if [ ! -f $HOME/.node_modules/bin/intelephense ];
then
   npm i -g intelephense
fi

echo -e "${green}...done!\n"
