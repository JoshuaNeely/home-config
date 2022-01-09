if [[ -n $SSH_CLIENT ]]; then
    REMOTE_SUFFIX="-remote"
else
    REMOTE_SUFFIX=""
fi

PS1='\A \[\e[32m\]\u$REMOTE_SUFFIX \[\e[36m\]\w\[\e[00m\] '
