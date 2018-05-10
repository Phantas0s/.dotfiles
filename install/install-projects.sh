# Clone projects from github / gitlab
# The key have to be created manually of course...
# Only Phantas0s have access to the repo via SSH :D

if [ -f $HOME/.ssh/github ];
    then
        mkdir $GOPATH/src/github.com/Phantas0s > /dev/null

        if [ ! -d $GOPATH/src/github.com/Phantas0s/watcher ];
        then
            echo -e "Installing the project Watcher in workspace"
            cd $GOPATH/src/github.com/Phantas0s
            git clone git@github.com:Phantas0s/watcher.git
            go install
            cd -
        fi

        if [ ! -d $GOPATH/src/github.com/Phantas0s/testomatic ];
        then
            echo -e "Installing the project Testomatic in workspace"
            cd $GOPATH/src/github.com/Phantas0s
            git clone git@github.com:Phantas0s/testomatic.git
            go install
            cd -
        fi

        if [ ! -d $GOPATH/src/github.com/Phantas0s/go-in-practice ];
        then
            echo -e "Installing the project Go in practice in workspace for reference"
            cd $GOPATH/src/github.com/Phantas0s
            git clone git@github.com:Phantas0s/go-in-practice.git
            cd -
        fi
fi
