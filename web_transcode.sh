#!/bin/bash

file="$1"

echo "encoding" $file "for web"

ffmpeg -i $file -an -b 345k -s 640x360 $file.ogv > /dev/null
ffmpeg -i $file -an -b 345k -s 640x360 $file.webm > /dev/null
ffmpeg -i $file \
    -an \
    -vcodec libx264 \
    -level 21 -refs 2 -b 345k -bt 345k \
    -threads 0 -s 640x360 $file.mp4 > /dev/null

echo "done"
