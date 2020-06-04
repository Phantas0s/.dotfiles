#!/bin/bash

rm -rf $XDG_CONFIG_HOME/redshift.conf
ln -sf $DOTFILES/redshift/redshift.conf $XDG_CONFIG_HOME
