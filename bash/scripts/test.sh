
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
