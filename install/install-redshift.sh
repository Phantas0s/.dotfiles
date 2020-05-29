#!/bin/bash

REDSHIFT_CONFIG_DIR=$HOME/.config/redshift/

mkdir -p $REDSHIFT_CONFIG_DIR
rm -rf $REDSHIFT_CONFIG_DIR/redshift.conf
ln -sf $DOTFILES/redshift/* ${REDSHIFT_CONFIG_DIR}/
