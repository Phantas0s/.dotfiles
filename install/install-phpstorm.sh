#!/bin/bash

echo ""
echo "${blue}Try to create symlink for Phpstorm (in /usr/bin/phpstorm)..."

if [ -z "$PHPSTORM_ROOT" ]
  then
      echo "${red}... no path configured in $ROOT_CONFIG/install_config"
else
    sudo ln -s -f $PHPSTORM_ROOT /usr/bin/phpstorm
    echo "${green}... done"
fi
