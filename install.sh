#!/usr/bin/env bash

function install_packages() {
    PACKAGES_TO_INSTALL=$1

    echo "$PACKAGES_TO_INSTALL"
    echo
    echo "Install these packages through pacman? [y/n]"
    read ANSWER

    case $ANSWER in
        y|Y) sudo pacman --noconfirm -S $PACKAGES_TO_INSTALL ;;
        *) echo "Ignored ..." ;;
    esac

    echo
}

function smart_link() {
    SOURCE="$1"
    DESTINATION="$2"
    DESTINATION_PARENT_DIR="$(dirname $DESTINATION)"

    if [ ! -e $SOURCE ]; then
        echo "No such file: \"$SOURCE\""
    else
        [[ ! -d $DESTINATION_PARENT_DIR ]] && mkdir -p $DESTINATION_PARENT_DIR

        [[ ! -e "$DESTINATION" ]]\
            && softlink_and_print "$SOURCE" "$DESTINATION"\
            || ask_to_replace_link "$SOURCE" "$DESTINATION"
    fi
}

function softlink_and_print() {
    SOURCE="$1"
    DESTINATION="$2"

    ln -nsrf "$SOURCE" "$DESTINATION"
    [[ $? -eq 0 ]] && echo "  $DESTINATION → $SOURCE"
}

function ask_to_replace_link() {
    SOURCE="$1"
    DESTINATION="$2"

    echo -n "\"$DESTINATION\" already exists. Replace it? [y/n] "
    read ANSWER

    case $ANSWER in
        y|Y) softlink_and_print $SOURCE $DESTINATION
    esac
}

function ask_to_install_yay() {
    echo -n "Install yay? [y/n] "
    read ANSWER

    case $ANSWER in
        y|Y) pacman -S --needed git base-devel\
                && git clone https://aur.archlinux.org/yay.git\
                && cd yay && makepkg -si
    esac
}

function ask_to_change_default_shell() {
    echo -n "Set fish as default shell? [y/n] "
    read ANSWER

    case $ANSWER in
        y|Y)
            echo /usr/bin/fish | sudo tee -a /etc/shells
            chsh -s /usr/bin/fish
            echo "Default shell changed for fish."
            echo "It will take effect on next login."
        ;;
    esac
}

DOTFILES_DIR=$(pwd)/dotfiles
PACKAGE_LIST_FILE="./lists/to_install_pacman.txt"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "No such directory: \"$DOTFILES_DIR\""
    echo "See the readme."

    exit 1
fi

if [ ! -f "$PACKAGE_LIST_FILE" ]; then
    echo "No such file: \"$PACKAGE_LIST_FILE\""
    echo "See the readme."

    exit 1
fi

install_packages "$(tr '\n' ' ' < $PACKAGE_LIST_FILE)"

smart_link "$DOTFILES_DIR/home/zshrc" ~/.zshrc
smart_link "$DOTFILES_DIR/home/Xdefaults" ~/.Xdefaults
smart_link "$DOTFILES_DIR/home/xinitrc" ~/.xinitrc

smart_link "$DOTFILES_DIR/config/alacritty/alacritty.yml"\
            ~/.config/alacritty/alacritty.yml
smart_link "$DOTFILES_DIR/config/i3/config" ~/.config/i3/config
smart_link "$DOTFILES_DIR/config/nvim/" ~/.config/nvim/
smart_link "$DOTFILES_DIR/config/dunst/dunstrc" ~/.config/dunst/dunstrc
smart_link "$DOTFILES_DIR/config/picom/picom.conf" ~/.config/picom/picom.conf
smart_link "$DOTFILES_DIR/config/fish" ~/.config/fish
smart_link "$DOTFILES_DIR/config/starship/starship.toml"\
            ~/.config/startship.toml

smart_link "$DOTFILES_DIR/config/eww/" ~/.config/eww

smart_link "./scripts" ~/.scripts
smart_link "./include" ~/.include
smart_link "./include/rofi-themes" ~/.config/rofi

ask_to_install_yay
ask_to_change_default_shell
