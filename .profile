# .profile is used for **loggin shells**, where bashrc is only used in interactive shells
# environments like tmux or ssh sessions would not bashrc, without something like this

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi
