#!/usr/bin/env bash


helpFunction()
{
  echo ""
  echo "Usage: $0 -b blend_mode -c frame_count -i input_file -o output_file"
}


blend_mode=darken
frame_count=1
while getopts "b:c:i:o:" opt
do
  case "$opt" in
    b ) blend_mode="$OPTARG" ;;
    c ) frame_count="$OPTARG" ;;
    i ) input_file="$OPTARG" ;;
    o ) output_file="$OPTARG" ;;
    ? ) helpFunction ;;

  esac
done

if [ -z "$input_file" ] || [ -z "$output_file" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

filter="tblend=all_mode=$blend_mode"

complex=""

for _ in $(seq 1 $(($frame_count)));
do
  complex="$filter,$complex"
done

echo $complex
ffmpeg -i $input_file -filter_complex "$complex" $output_file
