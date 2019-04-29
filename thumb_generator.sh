#!/bin/bash
usage="$(basename "$0") [-h] [-s src dir] [-d dest dir] -- create thumbnails from images \n
where: \n
    -h  show this help text \n
    -s  source directory where images are present \n
    -d  destination directory where thumbnails will be placed"

while getopts ':hs:d:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    d) dst=$OPTARG
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

if [ -z "$dst" ] || [ -z "$src" ]
then
	echo $usage
	exit 1
fi

j=0
for i in `ls $src/*.jpg`;
do 
	convert -define jpeg:size=400x400 $i  -thumbnail 400x400^ -gravity center -extent 400x400 $dst/$j.jpg;
	let j=$j+1
	echo "Img:$i Thumb: $j.jpg"; 
done
