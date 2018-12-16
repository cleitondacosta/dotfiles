#!/usr/bin/env bash

alias errcho=">&2 echo"

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

function install_dotfile()
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

function install_directory()
{
    SOURCE=$1
    DESTINATION=$2
    DESTINATION_PARENT_DIR=$(dirname $DESTINATION)

    if [ ! -d $SOURCE ]
    then
        errcho "No such directory: $SOURCE"
        echo "Ignored ..."
    elif [ -d $DESTINATION ]
    then
        echo
        echo "Directory \"$DESTINATION\" already exists."
        echo "That means that \"$SOURCE\" would be at:"
        echo "\"$DESTINATION/${SOURCE##*/}\""
        echo "Ignored ..."
        echo
    else
        if [ ! -d $DESTINATION_PARENT_DIR ]
        then
            mkdir -p $DESTINATION_PARENT_DIR
        fi

        softlink_and_print $SOURCE $DESTINATION
    fi
}

DOTFILES_DIR=$(pwd)/dotfiles

if [ ! -d "$DOTFILES_DIR" ]
then
    errcho "No such directory: $DOTFILES_DIR."
    errcho "See the readme."

    exit 1
fi

install_dotfile "$DOTFILES_DIR/Xdefaults" ~/.Xdefaults
install_dotfile "$DOTFILES_DIR/i3blocks.conf" ~/.i3blocks.conf
install_dotfile "$DOTFILES_DIR/i3config" ~/.config/i3/config
install_dotfile "$DOTFILES_DIR/nvimrc" ~/.config/nvim/init.vim
install_dotfile "$DOTFILES_DIR/ranger.conf" ~/.config/ranger/rc.conf
install_dotfile "$DOTFILES_DIR/bashrc" ~/.bashrc
install_dotfile "$DOTFILES_DIR/dunstrc" ~/.config/dunst/dunstrc
install_dotfile "$DOTFILES_DIR/qutebrowser_config.py" ~/.config/qutebrowser/config.py
install_directory "$DOTFILES_DIR/scripts" ~/.scripts
install_directory "$DOTFILES_DIR/rofi-themes" ~/.config/rofi
