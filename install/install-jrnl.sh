#!/bin/bash

rm -rf $XDG_CONFIG_HOME/jrnl &>/dev/null

rm $DOTFILES/jrnl/jrnl
cp $DOTFILES/jrnl/jrnl_template $DOTFILES/jrnl/jrnl

if [ -z "$JRNL_DEFAULT_PATH" ];
then
    echo "Jrnl config - Please enter the path of your default journal \n"
    echo "> "
    read JRNL_DEFAULT_PATH

    echo "JRNL_DEFAULT_PATH=$JRNL_DEFAULT_PATH" >> $DOTFILES/install_config
fi

sed -i -e "s~<djrnl>~${JRNL_DEFAULT_PATH}~g" $DOTFILES/jrnl/jrnl
ln -s -f $DOTFILES/jrnl/jrnl $XDG_CONFIG_HOME/jrnl
