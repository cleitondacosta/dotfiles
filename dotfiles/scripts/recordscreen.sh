#!/usr/bin/env dash

. ~/.scripts/recordscreen_functions.sh

killall ffmpeg

if [ $? -eq 0 ]
then
    notify-send "Already was recording, stopped. Abort."
    exit 1
fi

RECORD_DIR=~/video/capture
FILE_NAME="$(date "+%d_%m_%Y - %H:%M:%S").mkv"

if [ ! -d $RECORD_DIR ]
then 
    mkdir -p $RECORD_DIR
fi

record_screen_no_sound $RECORD_DIR/"$FILE_NAME"

if [ $? -ne 0 ]
then
    notify-send "New capture in: $RECORD_DIR"
else
    notify-send "Internal error"
fi
