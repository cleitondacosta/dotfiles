#!/usr/bin/env dash
# requires: ffmpeg, notify-send, pulseaudio

record_screen_no_sound()
{
    OUTPUT_FILE="$1"

    SCREEN_RESOLUTION="$(xdpyinfo | grep dimensions | awk '{print $2}')"

    ffmpeg \
        -probesize 10M \
        -y \
        -f x11grab \
        -s "$SCREEN_RESOLUTION" \
        -r 60 \
        -i :0.0 \
        -c:v libx264rgb -crf 0 -preset ultrafast \
        "$OUTPUT_FILE"

    return $?
}
