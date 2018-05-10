# extract <archive_file> - Extract the archive depending on its type
# compress <folder> - Compress a folder in tar.gz

# screenshot <area> win|scr|area - Compress a folder in tar.gz
# imgsize <img> - display width / height of an image
# imgresize <source> <width> - resize and create a new image <source>_<width> following aspect ratio

# gtD <name> - Delete a tag locally AND on the remote origin

# sshcreate <name> - create a new ssh at ~/.ssh/<name> with chmod 700

# matrix - Display the MATRIX

extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjf $1      ;;
      *.tar.gz)   tar xzf $1      ;;
      *.bz2)      bunzip2 $1      ;;
      *.rar)      rar x $1        ;;
      *.gz)       gunzip $1       ;;
      *.tar)      tar xf $1       ;;
      *.tbz2)     tar xjf $1      ;;
      *.tgz)      tar xzf $1      ;;
      *.zip)      unzip $1        ;;
      *.Z)        uncompress $1   ;;
      *)          echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

compress() {
    tar cvzf $1.tar.gz $1
}

screenshot () {
    DIR="${HOME}/documents/images/screenshots"
    DATE="$(date +%Y%m%d-%H%M%S)"
    NAME="${DIR}/screenshot-${DATE}.png"
    LOG="${DIR}/screenshots.log"

    # Check if the dir to store the screenshots exists, else create it:
    if [ ! -d "${DIR}" ]; then mkdir -p "${DIR}"; fi

    if [ ! -f "${LOG}" ]; then touch "${LOG}"; fi

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
}

imgsize() {
    width=$(identify -format "%w" "$1")> /dev/null
    height=$(identify -format "%h" "$1")> /dev/null

    echo -e "Size of $1: $width*$height"
}

imgresize() {
    filename=${1%\.*}
    extension="${1##*.}"
    separator="_"
    convert $1 -resize $2 "$filename$separator$2.$extension"
}

gtD() {
    git tag -d $1
    git push origin :refs/tags/$1
}

sshcreate() {
    if [ ! -z "$1" ];
    then
        ssh-keygen -f $HOME/.ssh/$1 -t rsa -N '' -C "Key $1 added via create-ssh-key script"
        chmod 700 $HOME/.ssh/$1*
    fi
}

matrix () {
    lines=$(tput lines)
    cols=$(tput cols)

    awkscript='
    {
        letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"
        lines=$1
        random_col=$3
        c=$4
        letter=substr(letters,c,1)
        cols[random_col]=0;
        for (col in cols) {
        line=cols[col];
        cols[col]=cols[col]+1;
        printf "\033[%s;%sH\033[2;32m%s", line, col, letter;
        printf "\033[%s;%sH\033[1;37m%s\033[0;0H", cols[col], col, letter;
        if (cols[col] >= lines) {
            cols[col]=0;
        }
        }
    }
    '

    echo -e "\e[1;40m"
    clear

    while :; do
    echo $lines $cols $(( $RANDOM % $cols)) $(( $RANDOM % 72 ))
    sleep 0.05
    done | awk "$awkscript"
}
