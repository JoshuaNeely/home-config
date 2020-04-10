# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'

    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    alias vi='vim'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias seetabs="cat -etv"

# git stuff
# allows mixing-in other kinds of commands, like sed filtering, etc
alias gs="git status"

# I wanted a way to clear stale remote branches
# It turns out `git fetch --prune` should do this too
# ...but this is a cool thing for the mental-toolbox so I'm keeping it as a template
# side note: to get the bash auto-completion I put a blank entry in [alias] in .gitconfig
git()
{
  if [ $# -gt 0 ] && [ "$1" == "clear-remotes" ] ; then
    shift
    command git branch -a | grep remotes | grep -v HEAD | sed 's.remotes/..g' | xargs -i git branch -rd {}
  else
    command git "$@"
  fi
}

# Replaces the "source venv/bin/activate" python virtualenv workflow
# "activate"  or  "activate [python version here]"
__activate () { source venv$1/bin/activate; }
alias activate=__activate

# allows ctl-c in sl. solving the real problems here
alias sl="sl -e"

# enabled colors in grep pipes
alias grep="grep --color=always"


# mark a directory and supply a name
# later recall to that location by name
# a reference to spells from Morrowind
MARK_FILES_PATH="/tmp/marks/"

mark() {
  mark_function() {
    MARK_NAME=$1
    NEW_MARKFILE_PATH=$MARK_FILES_PATH$MARK_NAME
    echo "creating $NEW_MARKFILE_PATH"
    mkdir -p $MARK_FILES_PATH
    echo $PWD > $NEW_MARKFILE_PATH
  }

  if [ $# -gt 0 ] ; then
    mark_function $1
  else
    echo "specify a name for the location"
    read LOCATION_NAME
    mark_function $LOCATION_NAME
  fi
}

recall() {
  recall_function() {
    MARKFILE_NAME=$1
    MARKFILE_PATH=$MARK_FILES_PATH$MARKFILE_NAME

    if [ -f $MARKFILE_PATH ] ; then
      RECALL_PATH=$( cat $MARKFILE_PATH )
      cd $RECALL_PATH
    else
      echo "the spell fizzles!"
    fi
  }

  if [ $# -gt 0 ] ; then
    if [ "$1" == "list" ] ; then
      ls $MARK_FILES_PATH
    else
      recall_function $1
    fi
  else
    # rudimentary tab completion!
    LOCATION_NAME=$(rlwrap -f <(ls /tmp/marks) bash -c 'read -p "recall where? " && echo $REPLY')
    recall_function $LOCATION_NAME
  fi
}
