#!/usr/bin/env bash

# file: backup_test.sh
# Doc: https://github.com/kward/shunit2

# Run before all tests
function oneTimeSetUp() {
    script=./backup.sh
    dirs=./dir.csv
}

# Run before each test
function setUp() {
    mkdir -p testdata/{source/a_directory,destination}
    touch testdata/source/{a_file,a_directory/another_file}

    source=testdata/source
    destination=testdata/destination

    file=./dir.csv
    echo "$source,$destination" > "$file"
}

function testOptionHelp() {
    assertContains "$($script -h)" help
}

function testOptionVersion() {
    assertContains "$($script -v)" "Version 1.0"
}

function testOptionsDryRun() {
    assertContains "$($script -d $dirs)" "(DRY RUN)"
}

function testDestination() {
    "$($script "$file")"
    assertTrue "[ $(find "$source" | wc -l) == $(find "$destination" | wc -l) ]"
}

function testNoDeleteByDefault() {
    "$($script "$file")"
    rm "$source/a_file"
    assertTrue "[ $(find "$source" | wc -l) != $(find "$destination" | wc -l) ]"
    "$($script "$file")"
    assertTrue "[ $(find "$source" | wc -l) != $(find "$destination" | wc -l) ]"
}

function testDeleteFile() {
    "$($script "$file")"
    rm "$source/a_file"
    assertTrue "[ $(find "$source" | wc -l) != $(find "$destination" | wc -l) ]"
    "$($script -x "$file")"
    assertTrue "[ $(find "$source" | wc -l) == $(find "$destination" | wc -l) ]"
}

function testCopyAFile() {
    "$($script "$file")"
    assertTrue "[ -f $destination/a_file ]"
}


# Run after each test
function tearDown() {
    if [[ -d ./testdata ]]; then
        rm -rf ./testdata
    fi
}

source shunit2
