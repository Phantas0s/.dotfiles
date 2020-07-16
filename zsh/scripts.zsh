#!/bin/sh

line() {
    [ ! -z $1 ] && sed -n "${1}p" && return
    [ ! -z $1 ] && [ ! -z $2 ] && sed -n $2 "${1}p" && return
}

screenres() {
    [ ! -z $1 ] && xrandr --current | grep '*' | awk '{print $1}' | line $1
}

screencast() {
    # Record screen 2 by default
    local screen=2
    local offset=""
    local heights=(`screenres 1 | awk -Fx '{print $2}'` `screenres 2 | awk -Fx '{print $2}'`)
    local bigger_height=$(echo $heights | sed "s/ /\n/" | sort -rg | line 1)

    if [ ! -z $2 ]; then
        screen=$2
    fi

    if [ ! -z $1 ]; then
       [ $screen -eq 1 ] && offset="+0,$(( $bigger_height -  $(screenres 1 | awk -Fx '{print $2}')))"
       [ $screen -eq 2 ] && offset="+$(screenres 1 | awk -Fx '{print $1}')"
       ffmpeg -f x11grab -s $(screenres $screen) -i :0.0$offset -f pulse -sample_rate 44100 -i default -c:v libx264 -preset ultrafast -c:a aac $1

       # Other codecs
       # -c:v ffvhuff   # lossless but HUGE
    else 
        echo "You need to precise an output file as first argument - eg 'example.mkv'"
    fi
}

all_screencast() {
    [ ! -z $1 ] && ffmpeg -f x11grab -s $(xdpyinfo | grep dimensions | awk '{print $2}') -i :0.0 -f pulse -i default $1 && return
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
}

extract() {
    if [ -f $1 ] ; then
        ex $1
    else
        echo "'$1' is not a valid file"
    fi
}

mkextract() {
    for file in "$@"
    do
        if [ -f $file ] ; then
            local filename=${file%\.*}
            mkdir -p $filename
            cp $file $filename
            cd $filename
            ex $file
            rm -f $file
            cd -
        else
            echo "'$1' is not a valid file"
        fi
    done
}

ex() {
    case $1 in
        *.tar.bz2)  tar xjf $1      ;;
        *.tar.gz)   tar xzf $1      ;;
        *.bz2)      bunzip2 $1      ;;
        *.gz)       gunzip $1       ;;
        *.tar)      tar xf $1       ;;
        *.tbz2)     tar xjf $1      ;;
        *.tgz)      tar xzf $1      ;;
        *.zip)      unzip $1        ;;
        *.7z)       7z x $1         ;; # require p7zip
        *.rar)      7z x $1         ;; # require p7zip
        *.iso)      7z x $1         ;; # require p7zip
        *.Z)        uncompress $1   ;;
        *)          echo "'$1' cannot be extracted" ;;
    esac
}

compress() {
    tar cvzf $1.tar.gz $1
}

screenshot () {
    local DIR="${HOME}/Documents/images/screenshots"
    local DATE="$(date +%Y%m%d-%H%M%S)"
    local NAME="${DIR}/screenshot-${DATE}.png"
    local LOG="${DIR}/screenshots.log"

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
        echo "No screenshot area has been specified. Please choose between: win, scr, area. Screenshot not taken."
        echo "${DATE}: No screenshot area has been defined. Screenshot not taken." >> "${LOG}"
    else
        # Save the screenshot in the directory and edit the log
        echo "${NAME}" >> "${LOG}"
    fi
}

imgsize() {
    local width=$(identify -format "%w" "$1")> /dev/null
    local height=$(identify -format "%h" "$1")> /dev/null

    echo -e "Size of $1: $width*$height"
}

imgresize() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    if [ ! -z $3 ]; then
        local finalName="$filename.$extension"
    else
        local finalName="$filename$separator$2.$extension"
    fi
    convert $1 -quality 100 -resize $2 $finalName
    echo "$finalName resized to $2"
}

imgresizeall() {
    for f in *.${1}; do
        if [ ! -z $3 ]; then
            imgresize "$f" ${2} t
        else
            imgresize "$f" ${2}
        fi
    done
}

imgoptimize() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    local suffix="optimized"
    local finalName="$filename$separator$suffix.$extension"
    convert $1 -strip -interlace Plane -quality 85% $finalName
    echo "$finalName created"
}

Imgoptimize() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    local suffix="optimized"
    local convert $1 -strip -interlace Plane -quality 85% $1
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
        local filename=${1%\.*}
        magick convert $1 "${filename}.jpg"
    else
        echo -e "You need to add an image to convert as param!"
    fi
}

imgconvpng() {
    if [ ! -z "$1" ];
    then
        local filename=${1%\.*}
        magick convert $1 "${filename}.png"
    else
        echo -e "You need to add an image to convert as param!"
    fi
}

imgwebp() {
    local IMG_EXT="jpg"
    if [ ! -z $1 ];
    then
        IMG_EXT=$1
    fi
    for F in *.$IMG_EXT; do cwebp -q 100 $F -o `basename ${F%.$IMG_EXT}`.webp; done
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

ssh-create() {
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
        local CYEAR=$(date +'%Y')
        local BASEDIR="${HOME}/workspace/webtechno/static"
        #Basedir current year
        local BASEDIRY="${HOME}/workspace/webtechno/static/${CYEAR}"

        if [ ! -d $BASEDIRY ]; 
        then
            mkdir $BASEDIRY
        fi

        #basedir current article
        local BASEDIRC="${BASEDIRY}/${2}"

        if [ ! -d $BASEDIRP ]; 
        then
            mkdir $BASEDIRP
        fi

        local IMGRESIZED=imgresize "${1} 780"
        echo "$IMGRESIZED"
    fi
}

postgdump() {
    local USER="postgres"
    local HOST="localhost"
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
    local USER="postgres"
    local HOST="localhost"
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
    local lines=$(tput lines)
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

git-heatmap() {
$DOTFILES/bash/scripts/heatmap.sh
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

mkcd() {
    dir="$*";
    mkdir -p "$dir" && cd "$dir";
}

mkcp() {
    dir="$2"
    tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -d "$dir" ] ||
    mkdir -p "$dir" &&
    cp -r "$@"
}

mkmv() {
    dir="$2"
    tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -d "$dir" ] ||
    mkdir -p "$dir" &&
    mv "$@"
}

historystat() {
    history 0 | awk '{print $2}' | sort | uniq -c | sort -n -r | head
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

mnt() {
    local FILE="/mnt/external"
    if [ ! -z $2 ];
    then
        FILE=$2
    fi

    if [ ! -z $1 ];
    then
        sudo mount "$1" "$FILE" -o rw
        echo "Device in read/write mounted in $FILE"
    fi

    if [ $# = 0 ]; 
    then
        echo "You need to provide the device (/dev/sd*) - use lsblk"
    fi
}

umnt() {
    local DIRECTORY="/mnt/"
    if [ ! -z $1 ];
    then
        DIRECTORY=$1
    fi
    MOUNTED=$(grep $DIRECTORY /proc/mounts | cut -f2 -d" " | sort -r)
    cd "/mnt/"
    sudo umount $MOUNTED
    echo "$MOUNTED unmounted"
}

mntmtp() {
    local DIRECTORY="$HOME/mnt/"
    if [ ! -z $2 ];
    then
        local DIRECTORY=$2
    fi
    if [ ! -d $DIRECTORY ]; 
    then
        mkdir $DIRECTORY
    fi

    if [ ! -z $1 ];
    then
        simple-mtpfs --device "$1" "$DIRECTORY"
        echo "MTPFS device in read/write mounted in $DIRECTORY"
    fi

    if [ $# = 0 ]; 
    then
        echo "You need to provide the device number - use simple-mtpfs -l"
    fi
}


umntmtp() {
    local DIRECTORY="$HOME/mnt"
    if [ ! -z $1 ];
    then
        DIRECTORY=$1
    fi
    cd $HOME
    umount $DIRECTORY
    echo "$DIRECTORY with mtp filesystem unmounted"
}

dlplaylist() {
    if [ ! -z $1 ];
    then
        youtube-dl -o "%(autonumber)s-%(title)s.%(ext)s" "$1"
    else
        echo "You need to specify a playlist url as argument between double quotes"
    fi
}

initKondo() {
    mkdir .clj-kondo
    clj-kondo --lint "$(boot with-cp -w -f -)"
}

pom() {
    local POMODORO_DURATION=25
    if [ ! -z $3 ];
    then
        POMODORO_DURATION=$3
    fi
    echo "(($1 * 60) + $2) / $POMODORO_DURATION" | bc
}

# open man page in vim
vman() {
    nvim -c "SuperMan $*"

    if [ "$?" != "0" ]; then
        echo "No manual entry for $*"
    fi
}

zshcomp() {
    for command completion in ${(kv)_comps:#-*(-|-,*)}
    do
        printf "%-32s %s\n" $command $completion
    done | sort
}



## TODO - TO REWORK
## Replace _ with underscore for filenames

# SOURCE=$1
# FILE_LIST="/tmp/find_list"

# if [[ ! -e "$SOURCE" ]]; # First check if the target does exist in the file system
# then
# 	echo "Target does not exist."
# 	exit 1
# fi

# if [[ -d $SOURCE ]]; # Checking if target is a directory
# then
# 	pushd "$SOURCE"
# 	find . -maxdepth 1 -type f -name "*" -printf %f"\n" > "$FILE_LIST"
# 	while read -r FILE
# 	do
# 		if [[ ! -z $FILE ]]; then
# 			rename 's/ /_/g' "$FILE"
# 		fi
# 	done < "$FILE_LIST"
# 	rm "$FILE_LIST"
#         popd
# 	exit 0
# elif [[ ! -d $SOURCE ]]; 
# then
# 	echo "Error! Please enter directory as input."
# 	exit 1
# fi	
