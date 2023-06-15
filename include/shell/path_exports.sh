function add_to_path() {
    [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && PATH="$PATH:$1" || return 1
}

add_to_path ~/.yarn/bin
add_to_path ~/.cargo/bin
add_to_path ~/.bin
add_to_path ~/.local/bin
add_to_path ~/.scripts
add_to_path ~/.sass
add_to_path ~/.flutter/bin

add_to_path /opt/android-sdk/platform-tools
add_to_path /opt/android-sdk/tools
add_to_path /opt/android-sdk/tools/bin
add_to_path /opt/android-sdk/tools/emulator
add_to_path ~/.pub-cache/bin

[[ -d "/opt/android-sdk" ]] && export ANDROID_HOME="/opt/android-sdk"

export PATH
export VISUAL=nvim
export EDITOR="$VISUAL"
export TERMINAL=alacritty
export TERM=alacritty

unset -f add_to_path
