# Usage: newp PROJECT_NAME PROJECT_LANGUAGE
#
# Description: Creates, in ~/code/$PROJECT_LANGUAGE/project, a new dev project 
# named $PROJECT_NAME and cd into it. If it already exists and it's a directory
# then it will just cd.
#
# Example: "newp todo-manager c" creates ~/code/c/project/todo-manager and cd
# into it.
function newp() {
    if [ $# -ne 2 ]; then
        echo "Usage: newp PROJECT_NAME PROJECT_LANGUAGE\n"
        echo "Creates a dir in ~/code/PROJECT_LANGUAGE/project/PROJECT_NAME."
        return 1
    fi

    PROJECT_NAME="$1"
    PROJECT_LANGUAGE="$2"
    DIR_TO_CREATE="$HOME/code/$PROJECT_LANGUAGE/project/$PROJECT_NAME"

    if [ -e "$DIR_TO_CREATE" ]; then
        echo "\"$DIR_TO_CREATE\" already exists."
        [[ -d "$DIR_TO_CREATE" ]] && cd "$DIR_TO_CREATE" && echo "Moved there."
        return 0
    fi

    mkdir -p "$DIR_TO_CREATE" && cd "$DIR_TO_CREATE" && echo "Moved there."
}

# Usage: rmp PROJECT_NAME PROJECT_LANGUAGE
#
# Description: Deletes the dir PROJECT_NAME in ~/code/PROJECT_LANGUAGE/project.
# If PROJECT_NAME dir is not empty, then the user must confirm the deletion.
# If PROJECT_LANGUAGE is an empty dir, then it will be deleted too.
# If the user is in any one of those dirs, then he will be moved to $HOME.
#
# Tip: I usually use it after calling newp function with typos.
#
# Example: rmp todo-menage x
function rmp() {
    if [ $# -ne 2 ]; then
        echo "Usage: rmp PROJECT_NAME PROJECT_LANGUAGE\n"
        echo "Deletes the dir PROJECT_NAME in ~/code/PROJECT_LANGUAGE/project."
    fi

    PROJECT_NAME="$1"
    PROJECT_LANGUAGE="$2"
    LANGUAGE_DIR="$HOME/code/$PROJECT_LANGUAGE"
    PROJECT_DIR="$HOME/code/$PROJECT_LANGUAGE/project"
    DIR_TO_DELETE="$HOME/code/$PROJECT_LANGUAGE/project/$PROJECT_NAME"

    if [ ! -d "$DIR_TO_DELETE" ]; then
        echo "No such directory: \"$DIR_TO_DELETE\""
        return 1
    fi

    # If $DIR_TO_DELETE is empty
    if [ -z "$(ls -A $DIR_TO_DELETE)" ]; then
        [[ "$(pwd)" == "$DIR_TO_DELETE" ]] && cd && echo "Moved home."
        rmdir "$DIR_TO_DELETE" && echo "Deleted: \"$DIR_TO_DELETE\"."
    else
        echo "Not empty: \"$DIR_TO_DELETE\""
        echo -n "Are you SURE that you want to DELETE it? [y/n] "
        read ANSWER

        case "$ANSWER" in
            y|Y)
                [[ "$(pwd)" == "$DIR_TO_DELETE" ]] && cd && echo "Moved home."
                rm -Rf "$DIR_TO_DELETE" && echo "Deleted: \"$DIR_TO_DELETE\"."
                ;;
            *)
                echo "Nothing done."
        esac
    fi

    DIR_TO_DELETE="$PROJECT_DIR"

    if [ -z "$(ls -A $DIR_TO_DELETE)" ]; then
        [[ "$(pwd)" == "$DIR_TO_DELETE" ]] && cd && echo "Moved home."
        rmdir "$DIR_TO_DELETE" && echo "Deleted empty dir: \"$DIR_TO_DELETE\"."
    fi

    DIR_TO_DELETE="$LANGUAGE_DIR"

    if [ -z "$(ls -A $DIR_TO_DELETE)" ]; then
        [[ "$(pwd)" == "$DIR_TO_DELETE" ]] && cd && echo "Moved home."
        rmdir "$DIR_TO_DELETE" && echo "Deleted empty dir: \"$DIR_TO_DELETE\"."
    fi
}

# Usage: t [N]
#
# Launches N terminals ($TERMINAL). If N is omitted, spawn only one. You can't
# spawn more than 10 or less than 1 terminals.
#
# Example: t 3
function t() {
    if [ $# -gt 1 ]; then
        echo "Usage: t [N]\n"
        echo "Launches N terminals. (\$TERMINAL must be setted)"
        return 1
    fi

    if [ -z "$TERMINAL" ]; then
        echo "Error: you need to set your TERMINAL variable."
        echo "(eg. TERMINAL=termite)"
        return 1
    fi

    if [ $# -eq 1 ]; then
        N=$1
        [[ $N -lt 1 ]] && echo "t: Invalid number." && return 1
        [[ $N -gt 10 ]] && echo "t: Number too high (10 max)." && return 1

        for i in {1..$N}; do
            "$TERMINAL" --title "terminal" . &!
        done
    else
        "$TERMINAL" --title "terminal" . &!
    fi
}

# Usage: bgimg IMAGE
#
# Uses feh to change background image. Also, it copies IMAGE to ~/.bg-image.
# If it already exists, it moves the current ~/.bg-image to 
# ~/image/old-bg-image.
#
# Example: bgimg ~/download/wallpaper.jpg
function bgimg() {
    if [ $# -ne 1 ]; then
        echo "Usage: bgimg IMAGE"
        echo "Description: Copies IMAGE to ~/.bg-image"
        return 1
    fi

    IMAGE="$1"
    DESTINATION="$HOME/.bg-image"

    if [ ! -f "$IMAGE" ]; then
        echo "No such regular file: $IMAGE."
        return 1
    fi

    if [ -e "$DESTINATION" ]; then
        echo "$DESTINATION: already exists."

        if [ ! -f "$DESTINATION" ]; then
            echo "$DESTINATION: Is not a regular file. Aborted."
            return 1
        fi

        OLD_BG_DIR="$HOME/image/old-bg-image"

        if [ ! -e "$OLD_BG_DIR" ]; then
            mkdir -p "$OLD_BG_DIR"
        else
            if [ ! -d "$OLD_BG_DIR" ]; then 
                echo "$OLD_BG_DIR: Is not a directory. Aborted."
                return 1
            fi
        fi

        mv --backup=numbered "$DESTINATION" "$OLD_BG_DIR/old"
        echo "$DESTINATION: moved into $OLD_BG_DIR."
    fi

    cp "$IMAGE" "$DESTINATION"
    echo "$IMAGE: copied to $DESTINATION."

    feh --bg-fill "$DESTINATION"
} 

# Translate text from english to portuguese.
function enpt() { 
    trans -b en: "$@" :pt 
}

# Translate text from portuguese to english.
function pten() { 
    trans -b pt: "$@" :en 
}

# Speak text in english.
function speak() { 
    trans -speak -s en "$@" 1>/dev/null 
}

# Meaning of english word.
function meaning() { 
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
