#!/usr/bin/env bash

# e - script stops on error (return != 0)
# u - error if undefined variable
# o pipefail - script fails if one of piped command fails
# x - output each line (debug)
set -uo pipefail

function output-help()
{
    echo "Usage :  $0 [options] [--]

    Options:
    -h|help       Display this message
    -v|version    Display script version
    -d|dry-run    Run rsync with --dry-run for test"
}

function run() {
    local rsync_opts=(-avz --delete)

    __ScriptVersion="1.0"

    while getopts ":hvd" opt
    do
    case $opt in

        h|help     )  output-help; exit 0   ;;

        v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

        d|dry-run  )  rsync_opts+=(--dry-run); ;;

        * )  echo -e "\n  Option does not exist : $OPTARG\n"
            output-help; exit 1   ;;

    esac
    done
    shift $(($OPTIND-1))

    [ "$#" == 0 ] && echo "You need to give a file as last argument" && exit 1

    local file="${!#}"
    while read -r line ; do
        src="$(eval echo -e "${line%,*}")"
        dest="$(eval echo -e "${line#*,}")"

        echo "Copying $src to $dest from file $file"
        [ ! -d "$src" ] && echo "The directory $src does not exist -- NO BACKUP CREATED" && continue

        rsync "${rsync_opts[@]}" "${src}/" "$dest" 2> /tmp/errors
    done < "$file"

    printf "ERRORS: \n"
    cat /tmp/errors
}

run "$@"
