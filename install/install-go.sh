#!/bin/bash

echo -e "${blue} installing Go environement..."

if [ ! -d $GOPATH/bin ];
then
    mkdir -d $GOPATH/bin
fi

if [ ! -f $GOPATH/bin/guru ];
then
    sh ./install/go/guru.sh
fi

if [ ! -f $GOPATH/bin/gocode ];
then
    sh ./install/go/gocode.sh
fi

if [ ! -f $GOPATH/bin/testomatic ];
then
    sh ./install/go/testomatic.sh
fi

if [ ! -f $GOPATH/bin/zb ];
then
    sh ./install/go/zb.sh
fi

if [ ! -f $GOPATH/bin/gometalinter ];
then
    sh ./install/go/gometalinter.sh
fi

if [ ! -f $GOPATH/bin/gotags ];
then
    sh ./install/go/gotags.sh
fi

if [ ! -f $GOPATH/bin/godef ];
then
    sh ./install/go/godef.sh
fi

if [ ! -f $GOPATH/bin/dlv ];
then
    sh ./install/go/dlv.sh
fi

if [ ! -f $GOPATH/bin/godoctor ];
then
    sh ./install/go/godoctor.sh
fi

if [ ! -f $GOPATH/bin/motion ];
then
    sh ./install/go/motion.sh
fi

echo -e "${green} ...done\n"
