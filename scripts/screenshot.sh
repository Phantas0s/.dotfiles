#!/bin/bash

DIR="${HOME}/documents/images/screenshots"
DATE="$(date +%Y%m%d-%H%M%S)"
NAME="${DIR}/screenshot-${DATE}.png"
LOG="${DIR}/screenshots.log"

# Check if the dir to store the screenshots exists, else create it:
if [ ! -d "${DIR}" ]; then mkdir -p "${DIR}"; fi

# Screenshot a selected window
if [ "$1" = "win" ]; then import -format png "${NAME}"; fi

# Screenshot the entire screen
if [ "$1" = "scr" ]; then import -format png -window root "${NAME}"; fi

# Screenshot a selected area
if [ "$1" = "area" ]; then import -format png "${NAME}"; fi

if [[ $# = 0 ]]; then
    # Display a warning if no area defined
    echo "No screenshot area has been specified. Screenshot not taken."
    echo "${DATE}: No screenshot area has been defined. Screenshot not taken." >> "${LOG}"
else
    # Save the screenshot in the directory and edit the log
    echo "${NAME}" >> "${LOG}"
fi
