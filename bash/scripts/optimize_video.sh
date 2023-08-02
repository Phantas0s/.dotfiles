#!/bin/sh

input_file=$1
output_file="$1.mp4"

if [ -z "$1" ] || [ "$1" = "-h" ]; then
	echo "$(basename $0) converts given file (.mov, .gif, etc.) to .mp4 using ffmpeg."
	echo "the output will be stored in the same directory of input file."
	echo "usage: $(basename $0) <input file>"
	echo "example: $(basename $0) my-screencast.mov"
	exit
fi

# verify dependencies
hash ffmpeg 2>/dev/null || { MISSING_DEPS="$MISSING_DEPS ffmpeg"; }
if [ ! -z "$MISSING_DEPS" ]; then
    echo "[ERROR] missing dependencies:"
    echo $MISSING_DEPS
    exit
fi

echo "[INFO] making mp4.."
echo "output file: $output_file"

# adapted from https://rigor.com/blog/optimizing-animated-gifs-with-html5-video
time ffmpeg \
  -hwaccel auto \
  -i "$input_file" \
  -movflags faststart \
  -pix_fmt yuv420p \
  -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
  -hide_banner -loglevel error \
  "$output_file"
