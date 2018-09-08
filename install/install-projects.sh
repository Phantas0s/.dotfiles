# Clone projects from github / gitlab
# The ssh key have to be created manually of course...
# Only Phantas0s have access to the repo via SSH :D

mkdir -p $GOPATH/src/github.com/Phantas0s > /dev/null


if [ -f $HOME/.ssh/gitlab ];
then
    if [ ! -d $HOME/workspace/sharetoall ];
    then
        echo -e "Installing the personnal project Sharetoall in workspace"
        cd $HOME/workspace
        git clone git@gitlab.com:Phantas0s/sharetoall.git
        cd -
    fi
    if [ ! -d $HOME/workspace/webtechno ];
    then
        echo -e "Installing the personnal project Webtechno in workspace"
        cd $HOME/workspace
        git clone --recursive git@gitlab.com:Phantas0s/webtechno.git
        cd -
    fi
else
    echo -e "${red}******************************************"
    echo -e "${red}Don't forget to create the ssh key: gitlab"
    echo -e "${red}******************************************"
fi

if [ -f $HOME/.ssh/github ];
then
    if [ ! -d $GOPATH/src/github.com/Phantas0s/watcher ];
    then
        echo -e "Installing the project Watcher in workspace"
        cd $GOPATH/src/github.com/Phantas0s
        git clone git@github.com:Phantas0s/watcher.git
        go get ./watcher
        cd -
    fi

    if [ ! -d $GOPATH/src/github.com/Phantas0s/devdash ];
    then
        echo -e "Installing the project Devdash in workspace"
        cd $GOPATH/src/github.com/Phantas0s
        git clone git@github.com:Phantas0s/devdash.git
        go get ./devdash
        go install ./devdash
        cd -
    fi

    if [ ! -d $GOPATH/src/github.com/Phantas0s/testomatic ];
    then
        echo -e "Installing the project Testomatic in workspace"
        cd $GOPATH/src/github.com/Phantas0s
        git clone git@github.com:Phantas0s/testomatic.git
        go get ./testomatic
        go install ./testomatic
        cd -
    fi

    if [ ! -d $GOPATH/src/github.com/Phantas0s/playground ];
    then
        echo -e "Installing the project Go in practice in workspace for reference"
        cd $HOME/workspace
        git clone git@github.com:Phantas0s/playground.git
        cd -
    fi

    if [ ! -d $HOME/workspace/ArchInstall ];
    then
        echo -e "Installing the project ArchInstall in workspace"
        cd $HOME/workspace
        git clone git@github.com:Phantas0s/ArchInstall.git
        cd -
    fi
else
    echo -e "${red}******************************************"
    echo -e "${red}Don't forget to create the ssh key: github"
    echo -e "${red}******************************************"
fi
