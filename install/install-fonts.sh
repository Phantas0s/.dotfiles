#!/bin/bash

echo ""
echo "${blue}Install the fonts..."

if [ ! -d $HOME/.fonts ]
  then
    mkdir $HOME/.fonts
fi

cp -f $HOME/$ROOT_CONFIG/fonts/* $HOME/.fonts

echo "${green} ...done"

