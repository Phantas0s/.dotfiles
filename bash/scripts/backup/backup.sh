#!/usr/bin/env bash

# e - script stops on error
# u - error if undefined variable
# o pipefail - script fails if command piped fails
set -euo pipefail

function handle-arguments() {
    local __ScriptVersion="1.0"

    while getopts ":hvdt" opt
    do
    case $opt in

        h|help     )  help; exit 0   ;;

        v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

        d|dry-run  )  rsync_opts+=(--dry-run);;

        * )  echo -e "\n  Option does not exist : $OPTARG\n"
            help; exit 1   ;;
    esac
    done
    shift $((OPTIND-1))
}

function help()
{
    echo "Usage :  $0 [options] [--]

    Options:
    -h|help       Display this message
    -v|version    Display script version
    -t|test       Run the unit tests"
}

function run()
{
   local rsync_opts=(-avz --delete)
   # handle-arguments and possibly mutate rsync_opts (depending of the arguments given)
   handle-arguments "$@"

    declare -A folders=(
        ["$HOME/Documents"]=home/Documents
        ["$HOME/Videos"]=home/Videos
        ["$HOME/Nextcloud"]=home/nextcloud
        ["$HOME/workspace"]=home/workspace
        ["$HOME/Games/scummvm"]=home/Games/scummvm
        ["$HOME/Games/internet"]=home/Games/internet
        ["$HOME/Games/dosbox"]=home/Games/dosbox
        ["$HOME/Games/emulators"]=home/Games/emulators
        ["$HOME/.local/share"]=home/.local/share
        ["$HOME/.thunderbird"]=home/.thunderbird
        ["$MEDIA/assets"]=assets
        ["$MEDIA/Documentaries"]=documentaries
        ["$MEDIA/Ebooks"]=ebooks
        ["$MEDIA/Install"]=install
        ["$MEDIA/MAO"]=mao
        ["$MEDIA/Music"]=music
        ["$MEDIA/Photos"]=photos
        ["$MEDIA/Video"]=video
    )

    # ! to expand the keys
    for key in "${!folders[@]}"; do
        local src=$key
        local dest="$MEDIA/BACKUP/${folders[$key]}"

        [ ! -d "$src" ] && echo "The directory $src doesn't exist -- NO BACKUP CREATED" && continue
        mkdir -p "$dest"

        rsync "${rsync_opts[@]}" "$src/" "$dest"
    done
}

run "$@"
