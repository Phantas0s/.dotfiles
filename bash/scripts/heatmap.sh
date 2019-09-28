#!/usr/bin/env bash

# Build a commit frequency histogram

ccyan="$(echo -ne '\033[0;36m')"
cnone="$(echo -ne '\033[0m')"

set -euo pipefail

ARGV=()
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -n)
      LIMIT="$2"
      shift
      shift
      ;;
    -b|--base)
      REVIEW_BASE="$2"
      shift
      shift
      ;;
    -c|--char)
      CHAR="$2"
      shift
      shift
      ;;
    --width)
      WIDTH="$2"
      shift
      shift
      ;;
    -f|--filter)
      FILTER="$2"
      shift
      shift
      ;;
    -h)
      cat <<EOF
Heatmap of oft-edited files.
Usage:
  git heatmap [options] [<path>...]
Options:
  -n <top>                      Limit to top <n> files. [default: 30]
  --width <n>                   Limit histogram to <n> chars.
  -b <branch>, --base <branch>  Compare relative to <branch>. If on <branch>,
                                show heatmap for entire repo. [default: master]
  -c <char>, --char <char>      Use <char> to draw the bars. [default: █]
  -f <cmd>, --filter <cmd>      Filter output through <cmd> before creating the
                                the histogram.
  -h                            Show this message.
EOF
      exit
      ;;
    *)
      ARGV+=("$1")
      shift
      ;;
  esac
done

LIMIT=${LIMIT:-30}
REVIEW_BASE=${REVIEW_BASE:-master}
CHAR=${CHAR:-█}
WIDTH=${WIDTH:-60}
FILTER=${FILTER:-cat -}

files() {
  # https://stackoverflow.com/questions/7577052/
  git log --name-status --pretty=format: -- "${ARGV[@]+"${ARGV[@]}"}" | \
    cut -f 2-
}

color_name() {
  if [ -t 1 ]; then
    sed -e "s/\(..*\/\)*\(.[^|]*\) |/\1$ccyan\2$cnone |/"
  else
    cat -
  fi
}

filter() {
  grep '.' | \
    eval "$FILTER" | \
    sort | \
    uniq -c | \
    sort -nr | \
    head -n "$LIMIT"
}

histogram() {
  bars --bar "$CHAR" --width "$WIDTH"
}

if [[ "$(git branch | grep '\*')" =~ $REVIEW_BASE ]]; then
  # If on master, show heatmap for whole repo
  files | filter | histogram | color_name
else
  MERGE_BASE="$(git merge-base HEAD "$REVIEW_BASE")"
  files | \
    # If on separate branch, show heatmap for files changed since master
    grep -xF -f <(git diff --name-only "$MERGE_BASE") | \
    filter | \
    histogram | \
    color_name
fi
