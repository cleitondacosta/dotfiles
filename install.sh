#!/usr/bin/env bash

function install_packages()
{
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

function smart_link()
{
    SOURCE="$1"
    DESTINATION="$2"
    DESTINATION_PARENT_DIR="$(dirname $DESTINATION)"

    if [ ! -e $SOURCE ]
    then
        echo "No such file: \"$SOURCE\""
    else
        [[ ! -d $DESTINATION_PARENT_DIR ]] && mkdir -p $DESTINATION_PARENT_DIR

        [[ ! -e "$DESTINATION" ]]\
            && softlink_and_print "$SOURCE" "$DESTINATION"\
            || ask_to_replace_link "$SOURCE" "$DESTINATION"
    fi
}


function softlink_and_print()
{
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

function recomendations()
{
    echo
    echo "Now that you're set, maybe you want to: "
    echo "  Install a display manager (with greeter?)?"
    echo "  Install aurman?"
    echo "  Install vim-plug?"
    echo "  Install Fura Mono Font for powerline?"
    echo "  Install light? (xbacklight may not work)"
    echo "  Change ~/.config/users-dirs.dirs?"
    echo
    echo "Remember: startx to launch the i3-gaps"
}

function ask_to_install_oh_my_zsh() {
    URL='https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh'

    echo -n "Install oh my zsh? [y/n]"
    read ANSWER

    case $ANSWER in
        y|Y) sh -c "$(wget $URL -O -)"
    esac
}

DOTFILES_DIR=$(pwd)/dotfiles
PACKAGE_LIST_FILE="./lists/to_install_pacman.txt"

if [ ! -d "$DOTFILES_DIR" ]
then
    echo "No such directory: \"$DOTFILES_DIR\""
    echo "See the readme."

    exit 1
fi

if [ ! -f "$PACKAGE_LIST_FILE" ]
then
    echo "No such file: \"$PACKAGE_LIST_FILE\""
    echo "See the readme."

    exit 1
fi

install_packages "$(tr '\n' ' ' < $PACKAGE_LIST_FILE)"

smart_link "$DOTFILES_DIR/Xdefaults" ~/.Xdefaults
smart_link "$DOTFILES_DIR/i3blocks.conf" ~/.i3blocks.conf
smart_link "$DOTFILES_DIR/i3config" ~/.config/i3/config
smart_link "$DOTFILES_DIR/nvimrc" ~/.config/nvim/init.vim
smart_link "$DOTFILES_DIR/termite.conf" ~/.config/termite/config
smart_link "$DOTFILES_DIR/ranger.conf" ~/.config/ranger/rc.conf
smart_link "$DOTFILES_DIR/zshrc" ~/.zshrc
smart_link "$DOTFILES_DIR/dunstrc" ~/.config/dunst/dunstrc
smart_link "$DOTFILES_DIR/xinitrc" ~/.xinitrc
smart_link "$DOTFILES_DIR/qutebrowser_config.py" \
                  ~/.config/qutebrowser/config.py

smart_link "./scripts" ~/.scripts
smart_link "./rofi-themes" ~/.config/rofi

ask_to_install_oh_my_zsh

recomendations
