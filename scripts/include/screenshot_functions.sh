add_png_extension() {
    FILE_NAME="$1"
    
    case "$FILE_NAME" in
        *.png) ;;
        *) FILE_NAME="$FILE_NAME.png"
    esac

    echo "$FILE_NAME"
}

screenshot_full_screen() {
    SCREENSHOT_DIR=$1
    FILE_NAME="$2"

    FILE_NAME="$(add_png_extension "$FILE_NAME")"

    scrot -q 100 "$SCREENSHOT_DIR/$FILE_NAME"
}

screenshot_current_window() {
    SCREENSHOT_DIR=$1
    FILE_NAME="$2"

    FILE_NAME="$(add_png_extension "$FILE_NAME")"

    scrot -u -q 100 "$SCREENSHOT_DIR/$FILE_NAME"
}

screenshot_selection() {
    SCREENSHOT_DIR=$1
    FILE_NAME="$2"

    FILE_NAME="$(add_png_extension "$FILE_NAME")"

    scrot -s -q 100 "$SCREENSHOT_DIR/$FILE_NAME"
}
