#!/usr/bin/env dash

. ~/.scripts/i3blocks/i3printcolor.sh 
. ~/.scripts/i3blocks/i3colortones.sh 

if [ "$(ps aux | grep -E [f]fmpeg | awk '{print $11}')" = "ffmpeg"  ]
then
    i3_print_color "🔴" "$RED_TONE"
fi
