#!/usr/bin/env bash

# initialize wallpaper daemon
swww init &
swww img ~/wallpapers/night.jpg &

# something about network manager?
nm-applet --indicator &

waybar -c ~/.config/waybar/waybar.json &

dunst &

udiskie &

hypridle
