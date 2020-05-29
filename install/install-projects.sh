# Clone projects from github / gitlab
# The ssh key have to be created manually of course...
# Only Phantas0s have access to the repo via SSH :D

mkdir -p $GOPATH/src/github.com/Phantas0s > /dev/null

mes "HELLO"

if [ -f $HOME/.ssh/gitlab ];
then
    if [ ! -d $HOME/workspace/webtechno ];
    then
        cd $HOME/workspace
        git clone --recursive git@gitlab.com:Phantas0s/webtechno.git
        cd -
    fi
else
dot_warn_mes "Please generate a 'gitlab' ssh-key"
fi

# TODO put all of that its in own file
if [ -f $HOME/.ssh/github ];
then
    if [ ! -d $GOPATH/src/github.com/Phantas0s/watcher ];
    then
        cd $GOPATH/src/github.com/Phantas0s
        git clone git@github.com:Phantas0s/watcher.git
        go get ./watcher
        cd -
    fi

    if [ ! -d $HOME/workspace/ottosocial ];
    then
        cd $HOME/workspace
        git clone git@github.com:Phantas0s/ottosocial.git
        go get ./ottosocial
        go install ./ottosocial
        cd -
    fi

    if [ ! -d $HOME/workspace/devdash ];
    then
        cd $HOME/workspace
        git clone git@github.com:Phantas0s/devdash.git
        go get ./devdash
        go install ./devdash
        cd -
    fi

    if [ ! -d $GOPATH/src/github.com/Phantas0s/testomatic ];
    then
        cd $GOPATH/src/github.com/Phantas0s
        git clone git@github.com:Phantas0s/testomatic.git
        go get ./testomatic
        go install ./testomatic
        cd -
    fi

    if [ ! -d $HOME/workspace/playground ];
    then
        cd $HOME/workspace
        git clone git@github.com:Phantas0s/playground.git
        cd -
    fi

    if [ ! -d $HOME/workspace/ArchInstall ];
    then
        cd $HOME/workspace
        git clone git@github.com:Phantas0s/ArchInstall.git
        cd -
    fi
else
    dot_warn_mes "Please generate a 'github' ssh-key"
fi
