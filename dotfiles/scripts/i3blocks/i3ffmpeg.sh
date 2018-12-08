#!/usr/bin/env dash

. ~/.scripts/i3blocks/i3printcolor.sh 
. ~/.scripts/i3blocks/i3colortones.sh 

pgrep ffmpeg > /dev/null
if [ $? -eq 0 ]
then
    i3_print_color "🔴" "$RED_TONE"
fi
