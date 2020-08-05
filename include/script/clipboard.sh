clipboard_set() {
    echo -n "$1" | xclip -sel clip
}

clipboard_get() {
    xclip -sel clip -o
}
