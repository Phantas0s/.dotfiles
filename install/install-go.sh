#!/bin/bash

echo -e "${blue} installing Go environement..."

if [ ! -d $GOPATH/bin ];
then
    mkdir -d $GOPATH/bin
fi

if [ ! -f $GOPATH/bin/guru ];
then
    sh ./go/guru.sh
fi

if [ ! -f $GOPATH/bin/gocode ];
then
    sh ./go/gocode.sh
fi

if [ ! -f $GOPATH/bin/testomatic ];
then
    sh ./install/go/testomatic.sh
fi

if [ ! -f $GOPATH/bin/zb ];
then
    sh ./go/zb.sh
fi

if [ ! -f $GOPATH/bin/gotags ];
then
    sh ./go/gotags.sh
fi

if [ ! -f $GOPATH/bin/godef ];
then
    sh ./go/godef.sh
fi

if [ ! -f $GOPATH/bin/dlv ];
then
    sh ./go/dlv.sh
fi

if [ ! -f $GOPATH/bin/godoctor ];
then
    sh ./go/godoctor.sh
fi

if [ ! -f $GOPATH/bin/motion ];
then
    sh ./go/motion.sh
fi

echo -e "${green} ...done\n"
