#!/bin/bash

function dot_red_mes() {
    echo -e "${red} ${1}"
}

function dot_mes() {
    echo -e "${1} ${2}"
}

function dot_mes_install() {
    dot_mes ${green} "--> Installing ${1}"
}

function dot_warn_mes() {
    echo -e "${red}/!\  ${1} /!\ "
}

function dot_install() {
    echo -e "${blue}-> Installing ${yellow}${1} ${blue}config"
    . $DOTFILES/install/install-${1}.sh
}

function dot_sub_install() {
    echo -e "${green}--> Installing ${1}"
}


function dot_is_installed() {
    command -v $1 >/dev/null
}
