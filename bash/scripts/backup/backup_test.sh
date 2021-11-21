#!/usr/bin/env bash
# file: backup_test.sh
# Doc: https://github.com/kward/shunit2

function oneTimeSetUp() {
    script=./backup.sh
}

function test-equality() {
    assertContains "$($script -h)" help
}

function test-dry-run() {
    assertContains "$($script -d)" "(DRY RUN)"
}

function test-version() {
    assertContains "$($script -v)" "Version"
}

function is-array() {
    local -r var=${1?}
    if [ -n "${var}" ]; then
        echo "The variable $var doesn't exist"
        return 1
    fi
    declare -p "$var" &> /dev/null || grep -q '^declare \-A' | grep -q '^typeset \-A'
    echo $?
}

. shunit2
