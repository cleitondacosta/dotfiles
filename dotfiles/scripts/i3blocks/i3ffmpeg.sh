#!/usr/bin/env dash

. ~/.scripts/include/i3printcolor.sh 
. ~/.scripts/include/i3colortones.sh 

pgrep ffmpeg > /dev/null
if [ $? -eq 0 ]
then
    i3_print_color "🔴" "$RED_TONE"
fi
