# TODO to refactor - create an hash table with path -> github
# Clone projects from github / gitlab
# The ssh key have to be created manually of course...
# Only Phantas0s have access to the repo via SSH :D

mkdir -p "$GOPATH/src/github.com/Phantas0s" > /dev/null

## Public projects

cd "$HOME/workspace" || exit
[ ! -d "$HOME/workspace/code-maat" ] && git clone https://github.com/adamtornhill/code-maat

## Private projects

if [ -f "$HOME/.ssh/github" ]; then
    CURRENT=$(pwd)

    mkdir -p "$HOME/Music"
    [ ! -d "$HOME/Music/playlists" ] && git clone git@github.com:Phantas0s/playlists $HOME/Music/playlists

    if [ ! -d "$HOME/workspace/webtechno" ]; then
        cd "$HOME/workspace" || exit
        mkdir "$HOME/workspace/webtechno"
        git clone --recursive git@github.com:Phantas0s/the_valuable_dev.git "$HOME/workspace/webtechno"
        cd "$HOME/workspace/webtechno" || exit
        if [ -d "$HOME/workspace/webtechno/githooks" ]; then
            cd .git/hooks/ || exit
            ln -s ../../githooks/* .
        fi
    fi

    if [ ! -d "$HOME/workspace/ottosocial" ]; then
        cd "$HOME/workspace" || exit
        git clone git@github.com:Phantas0s/ottosocial.git
        cd ottosocial || exit
        go build
        mv ottosocial "$GOBIN"
    fi

    if [ ! -d "$HOME/workspace/devdash" ]; then
        cd "$HOME/workspace" || exit
        git clone git@github.com:Phantas0s/devdash.git
        cd devdash || exit
        go build
        mv devdash "$GOBIN"
    fi

    if [ ! -d "$HOME/workspace/mouseless" ]; then
        mkdir -p "$HOME/workspace/mouseless"
        cd "$HOME/workspace/mouseless" || exit
        git clone git@github.com:Phantas0s/mouseless-dev landing_page
        git clone git@github.com:Phantas0s/mouseless_book book
        git clone git@github.com:Phantas0s/mouseless-dev-youtube video
        git clone git@github.com/Phantas0s/mouseless-book-behind-scene
        mkdir -p "$HOME/workspace/mouseless/installer" && cd "$HOME/workspace/mouseless/installer" || exit
        git clone git@github.com:Phantas0s/arch_installer
        git clone git@github.com:Phantas0s/dotfiles
        git clone git@github.com:Phantas0s/mouseless-book-companion
    fi

    if [ ! -d "$HOME/workspace/gocket" ]; then
        cd "$HOME/workspace" || exit
        git clone git@github.com:Phantas0s/gocket.git
        cd gocket || exit
        go build
        mv gocket "$GOBIN"
    fi

    if [ ! -d "$HOME/workspace/garden" ]; then
        cd "$HOME/workspace" || exit
        git clone git@github.com:Phantas0s/garden.git
        cd -
    fi

    if [ ! -d "$GOPATH/src/github.com/Phantas0s/testomatic" ]; then
        cd "$GOPATH/src/github.com/Phantas0s" || exit
        git clone git@github.com:Phantas0s/testomatic.git
        cd testomatic || exit
        go build
        mv testomatic "$GOBIN"
    fi

    if [ ! -d "$HOME/workspace/vim_courses" ]; then
        mkdir "$HOME/workspace/vim_courses"
        cd "$HOME/workspace/vim_courses" || exit
        git clone --recurse-submodules git@github.com:Phantas0s/vim-book.git book
    fi

    if [ ! -d "$HOME/workspace/playground" ]; then
        cd "$HOME/workspace" || exit
        git clone git@github.com:Phantas0s/playground.git
    fi

    if [ ! -d "$HOME/workspace/ArchInstall" ]; then
        cd "$HOME/workspace" || exit
        git clone git@github.com:Phantas0s/ArchInstall.git
    fi

    cd "$CURRENT" || exit
else
    dot_mes_warn "Please generate a 'github' ssh-key"
fi
