# note emacsclient doesn't respect assigning workspace because PID changes/forks. https://github.com/hyprwm/Hyprland/issues/8907
hyprctl dispatch exec [workspace 1 silent] "emacs"
hyprctl dispatch exec [workspace 2 silent] "kitty"
hyprctl dispatch exec [workspace 3 silent] "firefox"
