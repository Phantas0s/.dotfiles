#!/usr/bin/env bash

function dot_mes_red() {
    echo -e "${red} ${1}"
}

function dot_mes() {
    echo -e "${1} ${2}"
}

function dot_mes_install() {
    dot_mes ${green} "--> Installing ${1}"
}

function dot_mes_update() {
    dot_mes ${yellow} "--> Updating ${1}"
}

function dot_mes_warn() {
    echo -e "${red}/!\  ${1} /!\ "
}

function dot_install() {
    echo -e "${blue}-> Installing ${yellow}${1} ${blue}config"
    . "$DOTFILES/install/install-${1}.sh"
}

function dot_install_func() {
    echo -e "${blue}-> Installing ${yellow}${1} ${blue}config"
    . $DOTFILES/install/install-${1}.sh
    ${2}
}

function dot_sub_install() {
    echo -e "${green}--> Installing ${1}"
}


function dot_is_installed() {
    command -v $1 >/dev/null
}
