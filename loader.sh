#!/bin/bash
usage="$(basename "$0") [-h] [-s src dir] \n
where: \n
    -h  show this help text \n
    -s  source directory where images are present \n"

while getopts ':hs:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    s) src=$OPTARG
       ;;
    :) printf "missing -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

if [ -z "$src" ]
then
	echo $usage
	exit 1
fi

npm install express

mkdir thumbs
echo "*************Generating Thumbs **************************"
./thumb_generator.sh -s $src -d thumbs
echo "*************Generated Thumbs **************************"
echo "Starting server at http://127.0.0.1:8080/"
node photo_gallary.js 
