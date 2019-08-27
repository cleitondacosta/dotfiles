# Aliases
alias enpt="translate_english_to_portuguese"
alias pten="translate_portuguese_to_english"

function translate_english_to_portuguese() {
    trans -b en: "$@" :pt
}

function translate_portuguese_to_english() { 
    trans -b pt: "$@" :en 
}

function speak_in_english() { 
    trans -speak -s en "$@" 1>/dev/null 
}

function meaning_of_english_word() { 
    trans -d -s en "$1" | less -R 
}

function download_last_video_from_youtube_channel() {
    if [ $# -ne 1 ]; then
        echo "Usage: download_last_video_from_youtube_channel YOUTUBE_USER"
        return 1
    fi

    URL="https://www.youtube.com/user"
    USER="$1"
    URL="$URL/$USER/videos"

    VIDEO_PATH=~"/video/youtube/$USER"

    [[ ! -e "$VIDEO_PATH" ]] && mkdir -p "$VIDEO_PATH"

    youtube-dl "$URL" --max-downloads 1 -o "$VIDEO_PATH/%(title)s.%(ext)s"
}

function download_last_video_from_youtube_channel_as_mp3() {
    if [ $# -ne 1 ]; then
        echo "Usage: download_last_video_from_youtube_channel_as_mp3 YOUTUBE_USER"
        return 1
    fi

    URL="https://www.youtube.com/user"
    USER="$1"
    URL="$URL/$USER/videos"

    VIDEO_PATH=~"/video/youtube/$USER"

    [[ ! -d "$VIDEO_PATH" ]] && mkdir -p "$VIDEO_PATH"

    youtube-dl\
        --extract-audio\
        --audio-format mp3\
        --audio-quality 0\
        "$URL"\
        --max-downloads 1\
        -o "$VIDEO_PATH/%(title)s.%(ext)s"
}

function download_all_videos_from_youtube_channel() {
    if [ $# -ne 1 ]; then
        echo "Usage: download_all_videos_from_youtube_channel YOUTUBE_USER"
        return 1
    fi

    URL="https://www.youtube.com/user"
    USER="$1"
    URL="$URL/$USER/videos"

    VIDEO_PATH=~"/video/youtube/$USER"

    [[ ! -d "$VIDEO_PATH" ]] && mkdir -p "$VIDEO_PATH"

    youtube-dl "$URL" -o "$VIDEO_PATH/%(title)s.%(ext)s"
}

function download_first_video_from_youtube_search() {
    if [ $# -ne 1 ]; then
        echo "Usage: download_first_video_from_youtube_search SEARCH"
        return 1
    fi

    URL="https://www.youtube.com"
    SEARCH="$1"

    VIDEO_PATH=~"/video/youtube/$SEARCH"

    [[ ! -d "$VIDEO_PATH" ]] && mkdir -p "$VIDEO_PATH"

    youtube-dl\
        "ytsearch1: $SEARCH"\
        -o "$VIDEO_PATH/%(title)s.%(ext)s"\
        --max-downloads 1
}
