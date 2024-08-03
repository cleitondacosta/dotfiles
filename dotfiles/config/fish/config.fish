#!/usr/bin/env fish

set -u fish_greeting

source ~/.config/fish/aliases.fish

function add_to_path -a path
    if test -d $path && not contains $path $PATH
        set PATH $PATH $path
    end
end

add_to_path ~/.yarn/bin
add_to_path ~/.cargo/bin
add_to_path ~/.secret/scripts
add_to_path ~/.bin
add_to_path ~/.local/bin
add_to_path ~/.scripts
add_to_path ~/.sass
add_to_path ~/.flutter/bin
add_to_path ~/.pub-cache/bin
add_to_path /usr/lib/jvm/java-17-openjdk/bin/

if test -d /opt/android-sdk 
    set -x ANDROID_HOME /opt/android-sdk
end

if test -d ~/Android/Sdk
    set -x ANDROID_HOME ~/Android/Sdk
end

if test -f /opt/android-studio/bin/studio.sh
    set -x CAPACITOR_ANDROID_STUDIO_PATH /opt/android-studio/bin/studio.sh
end

add_to_path "$ANDROID_HOME/platform-tools"
add_to_path "$ANDROID_HOME/tools"
add_to_path "$ANDROID_HOME/tools/bin"
add_to_path "$ANDROID_HOME/tools/emulator"

set -x VISUAL nvim
set -x EDITOR $VISUAL
set -x TERMINAL alacritty
set -x TERM alacritty

functions -e add_to_path

starship init fish | source
