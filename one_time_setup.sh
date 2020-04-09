#!/bin/bash

# pull down Vundle; plugin manager for vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# automagically install Vundle plugins from .vimrc
vim +PluginInstall +qall

sudo apt install tmux
git clone git://github.com/airblade/vim-gitgutter.git

# tell vim to use plugins
vim +PluginInstall +qall

# restore versioned terminal settings
dconf reset -f /org/gnome/terminal/
dconf load /org/gnome/terminal/ < ./.gnome-terminal-settings.txt

# restore versioned keybindings settings
dconf reset -f /org/gnome/settings-daemon/plugins/media-keys/
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ./.gnome-keybindings.txt

# allows rudimentary tab completion for bash functions!
sudo apt install rlwrap
