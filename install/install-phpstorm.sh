#!/bin/bash

if [ -z "$PHPSTORM_ROOT" ]
  then
      echo "${red}... no path configured for PHPStorm in $ROOT_CONFIG/install_config"
elif [ ! -e /usr/bin/phpstorm ]
  then
    echo ""
    echo "${blue}Try to create symlink for Phpstorm (in /usr/bin/phpstorm)..."
    sudo ln -s -f $PHPSTORM_ROOT /usr/bin/phpstorm
    echo "${green}... done"
fi
