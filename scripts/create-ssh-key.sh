#!/bin/bash

if [ ! -z "$1" ];
then
    ssh-keygen -f $HOME/.ssh/$1 -t rsa -N '' -C "Key $1 added via create-ssh-key script"
    chmod 700 $HOME/.ssh/$1*
fi

