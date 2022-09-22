#!/usr/bin/env bash

path=$(find "$HOME/.thunderbird" -path '*yahoo.com' -type d)
cd $path
rm "$path/msgFilterRules.dat"
ln -s $CLOUD/apps/thunderbird/yahoo/msgFilterRules.dat
cd -
