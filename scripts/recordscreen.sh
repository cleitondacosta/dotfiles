#!/bin/sh
# requires: ffmpeg, notify-send, pulseaudio

# ** TODO **

# (pulse)
function record_screen_with_sound() {
    SCREEN_RESOLUTION="$( xdpyinfo | grep dimensions | awk '{print $2}' )"
    RECORD_DIR=~/video/capture
    FILE_NAME="$(date "+%d_%m_%Y - %H:%M:%S").mkv"
    FRAME_RATE=45

    if [ ! -d RECORD_DIR ]
    then
        mkdir -p $RECORD_DIR
    fi

    ffmpeg \
        -y \
        -f x11grab \
        -s "$SCREEN_RESOLUTION" \
        -i :0.0 \
        -f pulse -i default \
        -r $FRAME_RATE \
        -c:v libx264rgb -crf 0 -preset ultrafast\
        -c:a flac\
        "$RECORD_DIR/$FILE_NAME"

    return $?
}

killall ffmpeg

if [ $? -eq 0 ]
then
    notify-send "Stoped recording."
    exit 0
fi

record_screen_with_sound

if [ $? -ne 0 ]
then
    notify-send "New capture in: $RECORD_DIR"
else
    notify-send "Internal error"
fi
