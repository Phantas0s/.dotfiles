#!/usr/bin/env zsh

function fg-bg() {
    if [[ $#BUFFER -eq 0 ]]; then
        local backgroundProgram="$(jobs | tail -n 1 | awk '{print $4}')"
        case "$backgroundProgram" in
            "nc"|"ncat"|"netcat"|"resize-netcat-listener"|"rnc")
                # Make sure that /dev/tty is given to the stty command by doing </dev/tty
                terminal-size-clip < /dev/tty
                stty raw -echo < /dev/tty; fg
                ;;
            *)
                fg
                ;;
        esac
    else
        zle push-input
    fi
}

