#!/usr/bin/env bash

alias errcho=">&2 echo"

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

function softlink_and_print()
{
    SOURCE=$1
    DESTINATION=$2

    ln -s $SOURCE $DESTINATION
    [[ $? -eq 0 ]]\
        && echo "[>] $DESTINATION → $SOURCE"\
        || errcho "Couldn't link \"$SOURCE\" to \"$DESTINATION\"."
}

function softlink_force_and_print()
{
    SOURCE=$1
    DESTINATION=$2

    ln -sf $SOURCE $DESTINATION
    [[ $? -eq 0 ]]\
        && echo "[>] $DESTINATION → $SOURCE"\
        || errcho "Couldn't link \"$SOURCE\" to \"$DESTINATION\"."
}

function install_a_dotfile()
{
    SOURCE=$1
    DESTINATION=$2
    DESTINATION_PARENT_DIR=$(dirname $DESTINATION)

    if [ ! -f $SOURCE ]
    then
        errcho "Dotfile $SOURCE not found."
    else
        if [ ! -d $DESTINATION_PARENT_DIR ]
        then
            mkdir -p $DESTINATION_PARENT_DIR
        fi

        if [ -e "$DESTINATION" ]
        then
            echo -n "\"$DESTINATION\" already exists. Replace it? [y/n] "
            read ANSWER

            case $ANSWER in
                y|Y) softlink_force_and_print $SOURCE $DESTINATION
            esac
        else
            softlink_and_print $SOURCE $DESTINATION
        fi
    fi
}

function install_a_directory()
{
    SOURCE=$1
    DESTINATION=$2
    DESTINATION_PARENT_DIR=$(dirname $DESTINATION)

    if [ ! -d $SOURCE ]
    then
        errcho "No such directory: \"$SOURCE\". Ignored ..."
    elif [ -e $DESTINATION ]
    then
        echo "\"$DESTINATION\" already exists. Ignored ..."
    else
        if [ ! -d $DESTINATION_PARENT_DIR ]
        then
            mkdir -p $DESTINATION_PARENT_DIR
        fi

        softlink_and_print $SOURCE $DESTINATION
    fi
}

function recomendations()
{
    echo
    echo "Now that you're set, maybe you want to: "
    echo "  Install a display manager (with greeter?)?"
    echo "  Install aurman?"
    echo "  Install vim-plug?"
    echo "  Install light? (xbacklight may not work)"
    echo "  Change ~/.config/users-dirs.dirs?"
    echo
    echo "Remember: startx to launch the i3-gaps"
}

DOTFILES_DIR=$(pwd)/dotfiles
PACKAGE_LIST_FILE="./lists/to_install_pacman.txt"

if [ ! -d "$DOTFILES_DIR" ]
then
    errcho "No such directory: \"$DOTFILES_DIR\""
    errcho "See the readme."

    exit 1
fi

if [ ! -f "$PACKAGE_LIST_FILE" ]
then
    errcho "No such file: \"$PACKAGE_LIST_FILE\""
    errcho "See the readme."

    exit 1
fi

install_packages "$(tr '\n' ' ' < $PACKAGE_LIST_FILE)"

install_a_dotfile "$DOTFILES_DIR/Xdefaults" ~/.Xdefaults
install_a_dotfile "$DOTFILES_DIR/i3blocks.conf" ~/.i3blocks.conf
install_a_dotfile "$DOTFILES_DIR/i3config" ~/.config/i3/config
install_a_dotfile "$DOTFILES_DIR/nvimrc" ~/.config/nvim/init.vim
install_a_dotfile "$DOTFILES_DIR/ranger.conf" ~/.config/ranger/rc.conf
install_a_dotfile "$DOTFILES_DIR/bashrc" ~/.bashrc
install_a_dotfile "$DOTFILES_DIR/dunstrc" ~/.config/dunst/dunstrc
install_a_dotfile "$DOTFILES_DIR/qutebrowser_config.py" \
                  ~/.config/qutebrowser/config.py
install_a_dotfiles "$DOTFILES_DIR/xinitrc" ~/.xinitrc
install_a_directory "$DOTFILES_DIR/scripts" ~/.scripts
install_a_directory "$DOTFILES_DIR/rofi-themes" ~/.config/rofi

recomendations
