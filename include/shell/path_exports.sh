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
add_to_path ~/.pub-cache/bin

[[ -d /opt/android-sdk ]] && export ANDROID_HOME=/opt/android-sdk
[[ -d ~/Android/Sdk ]] && export ANDROID_HOME=~/Android/Sdk

add_to_path "$ANDROID_HOME/platform-tools"
add_to_path "$ANDROID_HOME/tools"
add_to_path "$ANDROID_HOME/tools/bin"
add_to_path "$ANDROID_HOME/tools/emulator"

export PATH
export VISUAL=nvim
export EDITOR="$VISUAL"
export TERMINAL=alacritty
export TERM=alacritty

unset -f add_to_path
