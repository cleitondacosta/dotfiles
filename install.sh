#!/bin/sh

alias errcho=">&2 echo"

function install_dotfile()
{
    SOURCE=$1
    DESTINATION=$2
    DESTINATION_PARENT_DIR=`dirname $DESTINATION`

    if [ ! -f $SOURCE ]
    then
        errcho "Dotfile $SOURCE not found."
    else
        if [ ! -d $DESTINATION_PARENT_DIR ]
        then
            mkdir -p $DESTINATION_PARENT_DIR
        fi

        ln -si $SOURCE $DESTINATION
    fi
}

function install_directory()
{
    SOURCE=$1
    DESTINATION=$2
    DESTINATION_PARENT_DIR=`dirname $DESTINATION`

    if [ ! -d $SOURCE ]
    then
        errcho "No such directory: $SOURCE"
    else
        if [ ! -d $DESTINATION_PARENT_DIR ]
        then
            mkdir -p $DESTINATION_PARENT_DIR
        fi

        ln -si $SOURCE $DESTINATION
    fi
}

DOTFILES_DIR=`pwd`/dotfiles

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
install_dotfile "$DOTFILES_DIR/zshrc" ~/.zshrc
install_dotfile "$DOTFILES_DIR/qutebrowser_config.py" ~/.config/qutebrowser/config.py
install_directory "$DOTFILES_DIR/scripts" ~/.scripts
