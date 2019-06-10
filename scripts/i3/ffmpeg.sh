#!/usr/bin/env bash

# The .mp4 extension is added to the file name in record_functions.sh

main() {
    abort_if_ffmpeg_already_running

    try_to_include_record_functions

    RECORD_DIR=~/video/capture
    DEFAULT_FILE_NAME="$(date "+%d_%m_%Y - %H:%M:%S")"

    if [ ! -d $RECORD_DIR ]
    then
        mkdir -p $RECORD_DIR
    fi

    ask_option_and_record "$RECORD_DIR/$DEFAULT_FILE_NAME" 
    abort_if_file_doesnt_exists "$RECORD_DIR/$DEFAULT_FILE_NAME.mp4"
    ask_to_rename_file_and_notify "$RECORD_DIR" "$DEFAULT_FILE_NAME.mp4"
}

abort_if_ffmpeg_already_running() {
    if [ ! -z $(pgrep ffmpeg) ]
    then
        exit 0
    fi
}

try_to_include_record_functions() {
    TO_INCLUDE=~/.scripts/include/record_functions.sh 

    if [ -e "$TO_INCLUDE" ]
    then
        . "$TO_INCLUDE"
    else
        notify-send "Capture" "Error: \"$TO_INCLUDE\" not found."
        exit 1
    fi
}

ask_option_and_record() {
    CAPTURE_FILE=$1

    ROFI_THEME=~/.config/rofi/option-list-theme.rasi

    OPTION_DESKTOP="mp4: Record 60fps with sound"
    OPTION_DESKTOP_NO_SOUND="mp4: Record 60fps without sound"
    OPTION_WHATSAPP="mp4: Record 30fps with sound (Whatsapp)"
    OPTION_WHATSAPP_NO_SOUND="mp4: Record 30fps without sound (Whatsapp)"
    OPTIONS="$OPTION_DESKTOP\n$OPTION_DESKTOP_NO_SOUND\n$OPTION_WHATSAPP\n$OPTION_WHATSAPP_NO_SOUND"

    OPTION_CHOSEN="$(echo -e "$OPTIONS" | rofi -theme $ROFI_THEME -dmenu)"

    case $OPTION_CHOSEN in
        $OPTION_DESKTOP)
            mp4_record "$CAPTURE_FILE" 60
            ;;
        $OPTION_DESKTOP_NO_SOUND)
            mp4_record_without_sound "$CAPTURE_FILE" 60
            ;;
        $OPTION_WHATSAPP)
            mp4_record_whatsapp_compliant "$CAPTURE_FILE" 30
            ;;
        $OPTION_WHATSAPP_NO_SOUND) 
            mp4_record_whatsapp_compliant_without_sound "$CAPTURE_FILE" 30
            ;;
        *) exit 0
    esac
}

abort_if_file_doesnt_exists() {
    FILE_NAME="$1"

    if [ ! -f "$FILE_NAME" ]
    then
        notify-send -u critical "Capture" "Couldn't capture."
        exit 1
    fi
}

ask_to_rename_file_and_notify() {
    FILE_DIR=$1
    CURRENT_FILE_NAME="$2"

    ROFI_THEME=~/.config/rofi/type-theme.rasi
    NEW_FILE_NAME="$(rofi -theme $ROFI_THEME -dmenu -p "File name: ")"

    if [ ! -z "$NEW_FILE_NAME" ]
    then
        NEW_FILE_NAME="$NEW_FILE_NAME.mp4"

        while [ -e $FILE_DIR/"$NEW_FILE_NAME" ]
        do
            NEW_FILE_NAME=$(
                rofi -theme $ROFI_THEME -dmenu -p \
                     "Already exists. Grab another name: "
            )
            NEW_FILE_NAME="$NEW_FILE_NAME.mp4"
        done
    
        mv "$FILE_DIR/$CURRENT_FILE_NAME" "$FILE_DIR/$NEW_FILE_NAME"
        CURRENT_FILE_NAME="$NEW_FILE_NAME"
    fi

    notify-send "New capture" "$FILE_DIR/$CURRENT_FILE_NAME"
}

main
