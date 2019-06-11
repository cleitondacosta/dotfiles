alias errcho=">&2 echo"

function append_to_path()
{
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="$PATH:$1"
    esac
}

function is_software_installed()
{
    # Checks if a software is installed. Only one parameter, Arch Linux only.
    # echoes 0 when the command was found.
    # echoes >0 when command wasn't an error occurred.
    # echoes 126 when command was found but couldn't be invoked.
    # echoes 127 when an iternal error occurred.

    if [ $# -ne 1 ]
    then
        errcho \
            "is_software_installed: error: Accepts only one parameter, not $#."
        return 1
    fi
    
    command -v "$1" > /dev/null
    echo $?
}

function search_software()
{
    # Search for a software name in Pacman
    if [ $(is_software_installed pacman) -ne 0 ]
    then
        errcho "This function requires pacman."
        errcho "Not in Arch?"
        return 1
    fi

    [[ "$EUID" != 0 ]] &&\
        echo "Requires sudo to sync database ... "
    sudo pacman -Fy
    
    if [ $? -ne 0 ]
    then
        errcho "An error occurred. Abort."
        return 1
    else
        columns=`tput cols`
        i=0
        dashes=""
        while [ $i -lt $columns ]
        do
            dashes="$dashes-"
            i=`expr $i + 1`
        done
        echo "$dashes"
    fi

    for arg in "$@"
    do
        pacman -Fs "$arg"
    done
}

function ffind() {
    if [ $# -ne 2 ]
    then
        errcho "ffind: Error: expected 2 arguments."
        errcho "ffind: Usage: ffind FILE_PATTERN TEXT_PATTERN"
        return 1
    fi

    find . -type f -iname "$1" -exec grep --color=auto -EHn "$2" {} \;
}

function translate_english_to_portuguese()
{
    if [ $(is_software_installed trans) -ne 0 ]
    then
        errcho "This function requires the software \'translate-shell\'."
        return 1
    fi

    if [ $# -ne 1 ]
    then
        errcho "Only one argument needed."
        return 1
    fi

    trans -b en: "$1" :pt
}

function translate_portuguese_to_english()
{
    if [ $(is_software_installed trans) -ne 0 ]
    then
        errcho "This function requires the software \'translate-shell\'."
        return 1
    fi

    if [ $# -ne 1 ]
    then
        errcho "Only one argument needed."
        return 1
    fi

    trans -b pt: "$1" :en
}

function speak_in_english()
{
    if [ $(is_software_installed trans) -ne 0 ]
    then
        errcho "This function requires the software \'translate-shell\'."
        return 1
    fi

    if [ $# -ne 1 ]
    then
        errcho "Only one argument needed."
        return 1
    fi

    trans -speak -s en "$1" 1>/dev/null
}


function meaning_of_english_word()
{
    if [ $(is_software_installed trans) -ne 0 ]
    then
        errcho "This function requires the software \'translate-shell\'."
        return 1
    fi

    if [ $# -ne 1 ]
    then
        errcho "Only one argument needed."
        return 1
    fi

    trans -d -s en "$1" | less -R
}

function download_last_video_from_youtube_channel()
{
    if [ $# -ne 1 ]
    then
        errcho "Usage: download_last_video_from_youtube_channel YOUTUBE_USER"
        return 1
    fi

    URL="https://www.youtube.com/user"
    USER="$1"
    URL="$URL/$USER/videos"

    VIDEO_PATH=~"/video/youtube/$USER"

    [[ ! -e "$VIDEO_PATH" ]] && mkdir -p "$VIDEO_PATH"

    youtube-dl "$URL" --max-downloads 1 -o "$VIDEO_PATH/%(title)s.%(ext)s"
}

function download_last_video_from_youtube_channel_as_mp3()
{
    if [ $# -ne 1 ]
    then
        errcho "Usage: download_last_video_from_youtube_channel_as_mp3 YOUTUBE_USER"
        return 1
    fi

    URL="https://www.youtube.com/user"
    USER="$1"
    URL="$URL/$USER/videos"

    VIDEO_PATH=~"/video/youtube/$USER"

    [[ ! -e "$VIDEO_PATH" ]] && mkdir -p "$VIDEO_PATH"

    youtube-dl\
        --extract-audio\
        --audio-format mp3\
        --audio-quality 0\
        "$URL"\
        --max-downloads 1\
        -o "$VIDEO_PATH/%(title)s.%(ext)s"
}

function download_all_videos_from_youtube_channel()
{
    if [ $# -ne 1 ]
    then
        errcho "Usage: download_all_videos_from_youtube_channel YOUTUBE_USER"
        return 1
    fi

    URL="https://www.youtube.com/user"
    USER="$1"
    URL="$URL/$USER/videos"

    VIDEO_PATH=~"/video/youtube/$USER"

    [[ ! -e "$VIDEO_PATH" ]] && mkdir -p "$VIDEO_PATH"

    youtube-dl "$URL" -o "$VIDEO_PATH/%(title)s.%(ext)s"
}

function download_first_video_from_youtube_search()
{
    if [ $# -ne 1 ]
    then
        errcho "Usage: download_first_video_from_youtube_search SEARCH"
        return 1
    fi

    URL="https://www.youtube.com"
    SEARCH="$1"

    VIDEO_PATH=~"/video/youtube/$SEARCH"

    [[ ! -e "$VIDEO_PATH" ]] && mkdir -p "$VIDEO_PATH"

    youtube-dl\
        "ytsearch1: $SEARCH"\
        -o "$VIDEO_PATH/%(title)s.%(ext)s"\
        --max-downloads 1
}
