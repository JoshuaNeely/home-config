#!/usr/bin/env bash

CONFIG_DIR=/home/josh/home-config
HOME_DIR=/home/josh

BACKUP_DIR=$HOME_DIR/home-config-backup
mkdir -p $BACKUP_DIR


symlink_config_file() {
    FILE_NAME=${1:?"ERROR: FILE_NAME not set!"}
    LINK_NAME=${2:-"$FILE_NAME"}

    if [[ -z $FILE_NAME ]] ; then
        echo "Missing file path!"
    else
        # backup if necessary
        mv $HOME_DIR/$LINK_NAME $BACKUP_DIR/$LINK_NAME 2>/dev/null

        # create a new symlink
        ln -s $CONFIG_DIR/$FILE_NAME $HOME_DIR/$LINK_NAME
    fi
}

echo "Backing up existing configurations to $BACKUP_DIR"
echo "Linking home-config/* files to $HOME"

# link directly to home directory
symlink_config_file ".dircolors"
symlink_config_file ".gitconfig"
symlink_config_file ".gnome-keybindings.txt"
symlink_config_file ".gnome-preferences.txt"
symlink_config_file ".gnome-terminal-settings.txt"
symlink_config_file ".profile"
symlink_config_file ".tmux.conf"
symlink_config_file ".vimrc"

# link with asymetric names/paths
symlink_config_file "bash_config/bashrc" ".bashrc"
symlink_config_file "emacs_configs/doom" ".doom.d"
