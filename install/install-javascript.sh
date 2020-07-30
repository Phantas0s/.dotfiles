#!/bin/bash

ln -sf $DOTFILES/javascript/.tern-project $HOME
ln -sf $DOTFILES/javascript/.eslintrc.json $HOME

# Works better than eslint for React
[ ! -d $NPM_PATH/lib/node_modules/babel-eslint ] && npm i -g babel-eslint

[ ! -d $NPM_PATH/lib/node_modules/eslint-plugin-html ] && npm i -g eslint-plugin-html

[ ! -f $NPM_PATH/bin/eslint ] && npm i -g eslint

[ ! -f $NPM_PATH/bin/bars ] && npm i -g https://github.com/jez/bars.git

[ ! -d $NPM_PATH/lib/node_modules/neovim ] && npm i -g neovim

[ ! -d $NPM_PATH/lib/node_modules/typescript ] && npm i -g typescript

[ ! -d $NPM_PATH/lib/node_modules/bash-language-server ]  && npm i -g bash-language-server
