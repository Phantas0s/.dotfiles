#!/bin/bash

social_networks=(
    twitter.com
    www.twitter.com
    api.twitter.com
    facebook.com
    www.facebook.com
    indiehackers.com
    www.indiehackers.com
)

if [[ ! -f /etc/hosts ]]; then
    echo "You don't have the file /etc/hosts. Are you worried?"
    exit 0
fi

if [[ ! -w /etc/hosts ]]; then
    echo "You can't write the file /etc/hosts. Try with sudo?"
    exit 0
fi

localhost=127.0.0.1

if [[ $1 == "lock" ]]; then
    for i in "${social_networks[@]}"; do
        sed -i "/^$localhost $i$/d" /etc/hosts
        echo "$localhost $i" >> /etc/hosts;
    done
elif [[ $1 == "unlock" ]]; then
    for i in "${social_networks[@]}"; do
        sed -i "/^$localhost $i$/d" /etc/hosts
    done
else
    echo "Please run this script with 'lock' or 'unlock' as argument and feel the productivity!"
fi


