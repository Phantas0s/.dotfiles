#!/bin/bash

echo "${blue} installing jrnl configuration..."

rm $HOME/$ROOT_CONFIG/jrnl/jrnl
cp $HOME/$ROOT_CONFIG/jrnl/jrnl_template $HOME/$ROOT_CONFIG/jrnl/jrnl

if [ -z "$JRNL_DEFAULT_PATH" ]
  then
    echo "Jrnl config - Please enter the path of your default journal \n"
    echo "> "
    read JRNL_DEFAULT_PATH
fi

sed -i -e "s~<djrnl>~${JRNL_DEFAULT_PATH}~g" $HOME/$ROOT_CONFIG/jrnl/jrnl

echo 'Create symlink for jrnl config...'

ln -s -f $HOME/$ROOT_CONFIG/jrnl/jrnl $HOME/jrnl

echo "${green} ...done"
