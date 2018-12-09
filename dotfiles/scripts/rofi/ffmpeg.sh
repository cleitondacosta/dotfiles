#!/usr/bin/env dash

THIS_SCRIPT_NAME="rofi/ffmpeg.sh"
RECORD_DIR=~/video/capture
FILE_NAME="$(date "+%d_%m_%Y - %H:%M:%S").mkv"

notify_if_recorded() {
    if [ -f $RECORD_DIR/"$FILE_NAME" ]
    then
        notify-send "$THIS_SCRIPT_NAME" "New capture in:\n$RECORD_DIR"
    fi
}

record_no_sound() {
    FRAME_RATE=$1

    SCREEN_RESOLUTION="$(xdpyinfo | grep dimensions | awk '{print $2}')"

    ffmpeg \
        -probesize 10M \
        -y \
        -f x11grab \
        -s "$SCREEN_RESOLUTION" \
        -r $FRAME_RATE \
        -i :0.0 \
        -c:v libx264rgb -crf 0 -preset ultrafast \
        $RECORD_DIR/"$FILE_NAME"

    return $?
}

killall ffmpeg

if [ $? -eq 0 ]
then
    notify_if_recorded
    exit 0
fi

if [ ! -d $RECORD_DIR ]
then 
    mkdir -p $RECORD_DIR
fi

OPTION_30FPS_NO_SOUND="Record 30fps without sound"
OPTION_60FPS_NO_SOUND="Record 60fps without sound"
OPTIONS="$OPTION_30FPS_NO_SOUND\n$OPTION_60FPS_NO_SOUND"

ANSWER=$(
    echo "$OPTIONS" |\
        rofi -dmenu -i -theme\
        ~/.dotfiles/dotfiles/rofi-themes/dmenu-dropdown-theme.rasi
)

case "$ANSWER" 
in
    $OPTION_30FPS_NO_SOUND) record_no_sound 30 ;;
    $OPTION_60FPS_NO_SOUND) record_no_sound 60 ;;
    *) exit 0 ;;
esac

notify_if_recorded
