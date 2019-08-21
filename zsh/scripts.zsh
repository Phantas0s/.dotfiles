screencast() {
  if [ ! -z $1 ] ; then
    ffmpeg -f x11grab -s $(xdpyinfo | grep dimensions | awk '{print $2}') -i :0.0 -f pulse -i default $1
  else
    echo "You need to precise an output file as first argument - eg 'example.mkv'"
  fi
}

oscreencast() {
  if [ ! -z $1 ] ; then
    ffmpeg -f x11grab -s $(xdpyinfo | grep dimensions | awk '{print $2}') -i :0.0 $1
  else
    echo "You need to precise an output file as first argument - eg 'example.mkv'"
  fi
}

updatesys() {
    sh $DOTFILES/update.sh
    if hash aurman 2>/dev/null; then
        aurman -Syu
    elif hash yay 2>/dev/null; then
        yay -Syu
    else
        sudo pacman -Syu
    fi
}

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
        echo "No screenshot area has been specified. Please choose a command: win, scr, area. Screenshot not taken."
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
    finalName="$filename$separator$2.$extension"
    convert $1 -quality 100 -resize $2 $finalName
    echo "$finalName"
}

imgresizeall() {
    for f in *.${1}; do
        imgresize "$f" ${2}
    done
}

imgoptimize() {
    filename=${1%\.*}
    extension="${1##*.}"
    separator="_"
    suffix="optimized"
    finalName="$filename$separator$suffix.$extension"
    convert $1 -strip -interlace Plane -quality 85% $finalName
    echo "$finalName created"
}

Imgoptimize() {
    filename=${1%\.*}
    extension="${1##*.}"
    separator="_"
    suffix="optimized"
    finalName="$filename$separator$suffix.$extension"
    convert $1 -strip -interlace Plane -quality 85% $1
    echo "$1 created"
}

imgoptimizeall() {
    for f in *.${1}; do
        imgoptimize "$f"
    done
}

Imgoptimizeall() {
    for f in *.${1}; do
        Imgoptimize "$f"
    done
}

imgconvjpg() {
    if [ ! -z "$1" ];
    then
        filename=${1%\.*}
        magick convert $1 "${filename}.jpg"
    else
        echo -e "You need to add an image to convert as param!"
    fi
}

imgconvpng() {
    if [ ! -z "$1" ];
    then
        filename=${1%\.*}
        magick convert $1 "${filename}.png"
    else
        echo -e "You need to add an image to convert as param!"
    fi
}

gtD() {
    git tag -d $1
    if [ ! -z "$2" ];
    then
        git push $2 :refs/tags/$1
    else
        git push origin :refs/tags/$1
    fi
}

sshcreate() {
    if [ ! -z "$1" ];
    then
        ssh-keygen -f $HOME/.ssh/$1 -t rsa -N '' -C "$1"
        chmod 700 $HOME/.ssh/$1*
    fi
}

dback () {
    if [ ! -z $1 ] && [ ! -z $2 ];
    then
        if [ ! -z $3 ];
        then
            BS=$3
        else
            BS="512k"
        fi

        dialog --defaultno --title "Are you sure?" --yesno "This will copy $1 to $2 (bitsize: $BS). Everything on $2 will be deleted.\n\n
              Are you sure?"  15 60 || exit

        (sudo pv -n $1 | sudo dd of=$2 bs=$BS conv=notrunc,noerror) 2>&1 | dialog --gauge "Backup from disk $1 to disk $2... please wait" 10 70 0
    else
        echo "You need to provide an input disk as first argument (i.e /dev/sda) and an output disk as second argument (i.e /dev/sdb)"
    fi

}

blimg() {
    if [ ! -z $1 ] && [ ! -z $2 ] && [ ! -z $3 ];
    then
        CYEAR=$(date +'%Y')
        BASEDIR="${HOME}/workspace/webtechno/static"
        #Basedir current year
        BASEDIRY="${HOME}/workspace/webtechno/static/${CYEAR}"

        if [ ! -d $BASEDIRY ]; 
        then
            mkdir $BASEDIRY
        fi

        #basedir current article
        BASEDIRC="${BASEDIRY}/${2}"

        if [ ! -d $BASEDIRP ]; 
        then
            mkdir $BASEDIRP
        fi

        IMGRESIZED=imgresize "${1} 780"
        echo "$IMGRESIZED"
    fi
}

postgdump() {
    USER="postgres"
    HOST="localhost"
    if [ ! -z $1 ];
    then
        if [ -f "${1}.sql" ];
        then
            rm -i "${1}.sql"
        fi

        if [ $# = 1 ];
        then
            pg_dump -c -U $USER -h $HOST $1 | pv --progress > "${1}.sql"
            echo $1
        fi

        if [ $# = 2 ];
        then
            pg_dump -c -U $2 -h $HOST $1 | pv --progress > "${1}.sql"
            echo $1
        fi

        if [ $# = 3 ];
        then
            pg_dump -c -U $2 -h $3 $1 | pv --progress > "${1}.sql"
            echo $1
        fi
    fi

    if [ $# = 0 ]; 
    then
        echo "You need at least to provide the database name"
    fi
}

postgimport() {
    USER="postgres"
    HOST="localhost"
    if [ ! -z $1 ];
    DB=${1%\.*}
    then
        # sed -i "1s/^/CREATE DATABASE $DB;\n/" $1
        if [ $# = 1 ];
        then
            pv --progress ${1} | psql -U $USER -h $HOST $1 -d $DB
            echo $1
        fi

        if [ $# = 2 ];
        then
            pv --progress ${1} | psql -U $1 -h $HOST $1 -d $DB
            echo $1
        fi

        if [ $# = 3 ];
        then
            pv --progress ${1} | psql -U $1 -h $2 $1 -d $DB
            echo $1
        fi
    fi

    if [ $# = 0 ]; 
    then
        echo "You need at least to provide the database name"
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

pgdump() {
    pg_dump -U postgres -h localhost x_loc_0bdf08de > pulsecheck_service_test.sql 
}

# Loopline system (my job) related
thriftgen() {
    thrift -o . -r --gen php:server -out ./php/gen  ./service.thrift 
    thrift -o . -r --gen go -out ./go/pkg/gen  ./service.thrift
}

colorblocks() {
    $DOTFILES/bash/scripts/colorblocks.sh
}

colorcards() {
    $DOTFILES/bash/scripts/colorcards.sh
}

pipes() {
    $DOTFILES/bash/scripts/pipes.sh
}

crypt() {
    [ $# -eq 1 ] && set -- "--encrypt" "$1"

    usage() { >&2 echo "Usage: crypt {-c,-d} <path>" 
            exit 1 ; }

    case "$1" in
        --encrypt|-c) 
            if [ -d "$2" ] ; then
                dash ${HOME}/bin/pack "$2"
                set 2 "${2%/}".tar.xz
            elif [ -f "$2" ] ; then
                xz -9 "$2"
                set 2 "$2".xz
            else 
                usage
            fi
            opts="-salt -e" ;;
        --decrypt|-d) 
            [ ! -e "$2" ] && usage
            opts="-d" ;;
        *) usage
    esac

    cat "$2" | openssl aes-256-cbc $opts -a -out "$2" &&

    case "$1" in
        --decrypt|-d) 
            xz -d "$2" 2> /dev/null &&
            tar xf "${2%.*}" 2> /dev/null && 
            rm -rf "${2%.*}" ;;
    esac
}

mkcd()
{
    dir="$*";
    mkdir -p "$dir" && cd "$dir";
}

updatezsh() {
    rm -f $DOTFILES/antibody/plugins.sh
    antibody bundle < $DOTFILES/antibody/plugins.txt > $DOTFILES/antibody/plugins.sh
    antibody update
}

promptspeed() {
    for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
}

ports() {
    sudo netstat -tulpn | grep LISTEN | fzf;
}
