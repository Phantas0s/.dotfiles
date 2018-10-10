#!/bin/bash
# TODO to refactor - parsing a list instead of those if everywhere...

echo -e "${blue} installing Go applications and tools..."

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
