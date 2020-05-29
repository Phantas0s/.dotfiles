#!/bin/bash

mkdir -p $GOPATH/bin

cd $DOTFILES/install/go

for f in *.sh; do
    filename=${f%\.*}
    if [ ! -f $GOPATH/bin/$filename ];
    then
        echo `./$f`
    fi
done

cd -
