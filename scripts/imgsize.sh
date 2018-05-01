width=$(identify -format "%w" "$1")> /dev/null
height=$(identify -format "%h" "$1")> /dev/null

echo -e "Width:$width"
echo -e "Height:$height"
