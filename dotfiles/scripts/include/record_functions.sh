mp4_record() {
    CAPTURE_FILE="$1"
    FRAME_RATE=$2

    SCREEN_RESOLUTION="$(xdpyinfo | grep dimensions | awk '{print $2}')"

    ffmpeg \
        -probesize 10M \
        -y \
        -f x11grab \
        -thread_queue_size 512 \
        -s "$SCREEN_RESOLUTION" \
        -r $FRAME_RATE \
        -i :0.0 \
        -f pulse -ac 2 -i default \
        -c:v libx264rgb \
        -crf 0 \
        -preset ultrafast \
        "$CAPTURE_FILE.mp4"
}

mp4_record_without_sound() {
    CAPTURE_FILE="$1"
    FRAME_RATE=$2

    SCREEN_RESOLUTION="$(xdpyinfo | grep dimensions | awk '{print $2}')"

    ffmpeg \
        -probesize 10M \
        -y \
        -f x11grab \
        -thread_queue_size 512 \
        -s "$SCREEN_RESOLUTION" \
        -r $FRAME_RATE \
        -i :0.0 \
        -c:v libx264rgb \
        -crf 0 \
        -preset ultrafast \
        "$CAPTURE_FILE.mp4"
}

mp4_record_whatsapp_compliant() {
    CAPTURE_FILE="$1"
    FRAME_RATE=$2

    SCREEN_RESOLUTION="$(xdpyinfo | grep dimensions | awk '{print $2}')"

    ffmpeg \
        -probesize 10M \
        -y \
        -f x11grab \
        -thread_queue_size 512 \
        -s "$SCREEN_RESOLUTION" \
        -r $FRAME_RATE \
        -i :0.0 \
        -f pulse -ac 2 -i default \
        -c:v libx264 \
        -preset fast \
        -profile:v baseline \
        -level 3.0 \
        -pix_fmt yuv420p \
        "$CAPTURE_FILE.mp4"
}

mp4_record_whatsapp_compliant_without_sound() {
    CAPTURE_FILE="$1"
    FRAME_RATE=$2

    SCREEN_RESOLUTION="$(xdpyinfo | grep dimensions | awk '{print $2}')"

    ffmpeg \
        -probesize 10M \
        -y \
        -f x11grab \
        -thread_queue_size 512 \
        -s "$SCREEN_RESOLUTION" \
        -r $FRAME_RATE \
        -i :0.0 \
        -c:v libx264 \
        -preset fast \
        -profile:v baseline \
        -level 3.0 \
        -pix_fmt yuv420p \
        "$CAPTURE_FILE.mp4"
}
