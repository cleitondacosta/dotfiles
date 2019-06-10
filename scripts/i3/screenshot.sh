#!/usr/bin/env dash

# The sleep here is used to delay after the user select an option.
# This is needed to prevent the rofi window to appear in the screenshot.

main() {
    try_to_include_screenshot_functions

    SCREENSHOT_DIR=~/image/screenshot
    SCREENSHOT_FILE="$(date "+%d_%m_%Y - %H:%M:%S").png"

    ask_option_and_screenshot "$SCREENSHOT_DIR" "$SCREENSHOT_FILE"
    ask_to_rename_file_and_notify "$SCREENSHOT_DIR" "$SCREENSHOT_FILE"
}

try_to_include_screenshot_functions() {
    TO_INCLUDE=~/.scripts/include/screenshot_functions.sh

    if [ -f "$TO_INCLUDE" ]
    then
        . "$TO_INCLUDE"
    else
        notify-send "Screenshot" "Error: Couldn't include \"$TO_INCLUDE\""
        exit 1
    fi
}

ask_option_and_screenshot() {
    SCREENSHOT_DIR=$1
    SCREENSHOT_FILE=$2

    ROFI_THEME=~/.config/rofi/option-list-theme.rasi

    OPTION_FULL_SCREEN="Full screen"
    OPTION_CURRENT_WINDOW="Current window"
    OPTION_SELECTION="Selection"
    OPTIONS="$OPTION_FULL_SCREEN\n$OPTION_CURRENT_WINDOW\n$OPTION_SELECTION"

    OPTION_CHOSEN=$(echo "$OPTIONS" | rofi -theme $ROFI_THEME -dmenu)

    case $OPTION_CHOSEN in
        $OPTION_FULL_SCREEN)
            sleep 0.4
            screenshot_full_screen "$SCREENSHOT_DIR" "$SCREENSHOT_FILE"
            ;;
        $OPTION_CURRENT_WINDOW)
            sleep 0.4
            screenshot_current_window "$SCREENSHOT_DIR" "$SCREENSHOT_FILE"
            ;;
        $OPTION_SELECTION) 
            screenshot_selection "$SCREENSHOT_DIR" "$SCREENSHOT_FILE"
            ;;
        *) exit 0
    esac
}


ask_to_rename_file_and_notify() {
    FILE_DIR=$1
    FILE_NAME="$2"

    ROFI_THEME=~/.config/rofi/type-theme.rasi
    NEW_FILE_NAME="$(rofi -theme $ROFI_THEME -dmenu -p "File name: ")"

    if [ ! -z "$NEW_FILE_NAME" ]
    then
        NEW_FILE_NAME="$(add_png_extension "$NEW_FILE_NAME")"

        while [ -e "$FILE_DIR/$NEW_FILE_NAME" ]
        do
            NEW_FILE_NAME=$(
                rofi -theme $ROFI_THEME -dmenu -p \
                     "Already exists. Grab another name: "
            )

            NEW_FILE_NAME="$(add_png_extension "$NEW_FILE_NAME")"
        done

    
        mv "$FILE_DIR/$FILE_NAME" "$FILE_DIR/$NEW_FILE_NAME"
        FILE_NAME="$NEW_FILE_NAME"
    fi

    notify-send "New screenshot" "$FILE_DIR/$FILE_NAME"
}

main
