#!/bin/sh
# Requires: scrot, notify_send
# Usage screenshot.sh (FULL|CURWIN|SELECT)

function show_usage_and_exit()
{
    echo "Usage: screenshot.sh (FULL|CURWIN|SELECT)"
    exit 1
}

if [ $# -ne 1 ]
then
    show_usage_and_exit
fi

MODE="$1"
SCREENSHOT_DIR=~/image/screenshot

if [ ! -d $SCREENSHOT_DIR ]
then
    mkdir -p $SCREENSHOT_DIR
fi

case "$MODE"
in
    FULL)
        scrot -q 100 %d_%m_%Y-%H:%M:%S.png -e\
            "mv --backup=t \$f $SCREENSHOT_DIR"
        ;;
    SELECT)
        scrot -s -q 100 %d_%m_%Y-%H:%M:%S.png -e\
            "mv --backup=t \$f $SCREENSHOT_DIR"
        ;;
    CURWIN)
        scrot -u -q 100 %d_%m_%Y-%H:%M:%S.png -e\
            "mv --backup=t \$f $SCREENSHOT_DIR"
        ;;
    *)
        show_usage_and_exit
esac

if [ $? -eq 0 ]
then
    notify-send "Screenshot" "New screenshot in:\n$SCREENSHOT_DIR"
else
    notify-send "Screenshot" "Couldn't take the screenshot."
fi
