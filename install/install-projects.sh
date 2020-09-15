# Clone projects from github / gitlab
# The ssh key have to be created manually of course...
# Only Phantas0s have access to the repo via SSH :D

mkdir -p "$GOPATH/src/github.com/Phantas0s" > /dev/null

if [ -f "$HOME/.ssh/github" ]; then
    if [ ! -d "$HOME/workspace/webtechno" ]; then
        CURRENT=$(pwd)

        cd "$HOME/workspace"
        mkdir "$HOME/workspace/webtechno"
        git clone --recursive git@github.com:Phantas0s/the_valuable_dev.git "$HOME/workspace/webtechno"
        cd "$HOME/workspace/webtechno"
        if [ -d "$HOME/workspace/webtechno/githooks" ]; then
            cd .git/hooks/
            ln -s ../../githooks/* .
        fi
        cd "$CURRENT"
    fi
    if [ ! -d "$HOME/workspace/ottosocial" ]; then
        cd "$HOME/workspace"
        git clone git@github.com:Phantas0s/ottosocial.git
        go get ./ottosocial
        go install ./ottosocial
        cd -
    fi

    if [ ! -d "$HOME/workspace/devdash" ]; then
        cd "$HOME/workspace"
        git clone git@github.com:Phantas0s/devdash.git
        go get ./devdash
        go install ./devdash
        cd -
    fi

    if [ ! -d "$GOPATH/src/github.com/Phantas0s/testomatic" ]; then
        cd "$GOPATH/src/github.com/Phantas0s"
        git clone git@github.com:Phantas0s/testomatic.git
        go get ./testomatic
        go install ./testomatic
        cd -
    fi

    if [ ! -d "$HOME/workspace/playground" ]; then
        cd "$HOME/workspace"
        git clone git@github.com:Phantas0s/playground.git
        cd -
    fi

    if [ ! -d "$HOME/workspace/ArchInstall" ]; then
        cd "$HOME/workspace"
        git clone git@github.com:Phantas0s/ArchInstall.git
        cd -
    fi
else
    dot_mes_warn "Please generate a 'github' ssh-key"
fi
