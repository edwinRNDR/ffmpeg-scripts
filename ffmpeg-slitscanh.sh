#!/usr/bin/env bash

helpFunction()
{
  echo ""
  echo "Usage: $0 -i input_file -o output_file"
}


blend_mode=darken
frame_count=1
width=1920
height=1080
rate=30
while getopts "i:o:h:w:r:" opt
do
  case "$opt" in
    i ) input_file="$OPTARG" ;;
    o ) output_file="$OPTARG" ;;
    h ) height="$OPTARG" ;;
    w ) width="$OPTARG" ;;
    ? ) helpFunction ;;

  esac
done

if [ -z "$input_file" ] || [ -z "$output_file" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

ffmpeg -i $input_file -f image2 -r $rate image-%4d.jpg
mogrify -crop $(($width ))x1+0+$(($height / 2)) image*.jpg
montage image*.jpg -tile 1x -mode concatenate $output_file
rm image*.jpg