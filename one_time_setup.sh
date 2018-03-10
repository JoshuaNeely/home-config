#!/bin/bash

# pull down Vundle; plugin manager for vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# automagically install Vundle plugins from .vimrc
vim +PluginInstall +qall

apt install tmux
