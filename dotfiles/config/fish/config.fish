#!/usr/bin/env fish

set -u fish_greeting

source ~/.config/fish/aliases.fish

function add_to_path -a path
    if test -d $path && not contains $path $PATH
        set PATH $PATH $path
    end
end

function set_env_var_if_file_exists -a var file
    if test -e "$file"; and test -n "$var"
        set -gx "$var" "$file"
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
add_to_path /opt/nvim-linux-x86_64/bin

set_env_var_if_file_exists ANDROID_HOME /opt/android-sdk
set_env_var_if_file_exists ANDROID_HOME ~/Android/Sdk
set_env_var_if_file_exists CAPACITOR_ANDROID_STUDIO_PATH \
    /opt/android-studio/bin/studio.sh
set_env_var_if_file_exists CAPACITOR_ANDROID_STUDIO_PATH \
    ~/android-studio/bin/studio.sh

add_to_path "$ANDROID_HOME/platform-tools"
add_to_path "$ANDROID_HOME/tools"
add_to_path "$ANDROID_HOME/tools/bin"
add_to_path "$ANDROID_HOME/tools/emulator"

set -x VISUAL nvim
set -x EDITOR $VISUAL
set -x TERMINAL alacritty
set -x TERM alacritty
set -g fish_autosuggestion_enabled 0

functions -e add_to_path
functions -e set_env_var_if_dir_exists

starship init fish | source
