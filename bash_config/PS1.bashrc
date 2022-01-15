GREEN="\[\e[32m\]"
BLUE="\[\e[36m\]"
MAGENTA="\[\e[35m\]"
WHITE="\[\e[00m\]"

if [[ -n $SSH_CLIENT ]]; then
    REMOTE_SUFFIX="-remote"
else
    REMOTE_SUFFIX=""
fi

function get_git_dir() {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo "($(git branch --show-current))"
    else
        echo ""
    fi
}

TIME="$WHITE\A"
USER_NAME="$GREEN\u$REMOTE_SUFFIX"
DIRECTORY="$BLUE\w"
CURRENT_BRANCH="$MAGENTA\$(get_git_dir)"
NEW_LINE_PROMPT="$WHITE\n> "

PS1="$TIME $USER_NAME $DIRECTORY $CURRENT_BRANCH $NEW_LINE_PROMPT"
