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


# synchronize a local file to the same directory in a different computer
# push the local to the remote
push-file-to-remote-pwd() {
  CURRENT_DIR=$(pwd)
  FILE=$1
  REMOTE=$2

  if [ -z "$REMOTE" ] ; then
    echo "specify a remote ip to sync the current directory"
    echo "$FUNCNAME FILE REMOTE"
    exit 1
  fi

  if [ -z "$FILE" ] ; then
    echo "specify a local file to sync to the remote"
    exit 1
  fi

  ssh $USER@$REMOTE "mkdir -p $CURRENT_DIR"
  scp $CURRENT_DIR/$FILE $USER@$REMOTE:$CURRENT_DIR/$FILE
}

# synchronize a local file to the same directory in a different computer
# pull the remote to local
pull-file-from-remote-pwd() {
  CURRENT_DIR=$(pwd)
  FILE=$1
  REMOTE=$2

  if [ -z "$REMOTE" ] ; then
    echo "specify a remote ip to sync the current directory"
    echo "$FUNCNAME FILE REMOTE"
    exit 1
  fi

  if [ -z "$FILE" ] ; then
    echo "specify a local file to sync to the remote"
    exit 1
  fi

  scp $USER@$REMOTE:$CURRENT_DIR/$FILE $CURRENT_DIR/$FILE
}

kill-matching-ps() {
  if [ $# -eq 0 ] ; then
    echo "provide a process name match string as an argument"
    return 0
  fi

  GREP_MATCH=$1

  echo "deleting these processes: "
  ps -aux | grep "$GREP_MATCH" | grep -v grep | awk '{ printf "%s ", $2 ; for (i = 11; i <= NF; i++) { printf "%s ", $i } ; print "" }'
  ps -aux | grep "$GREP_MATCH" | grep -v grep | awk '{ print $2 }' | xargs kill -9
}


# this is intended to target a k3s deploymed I set up, with a dashboard and admin user configured
# you could probably use it for other kubernetes deployments with the appropriate users set up
copy-dashboard-token-to-clipboard() {
    kubectl -n kubernetes-dashboard create token admin-user | xclip -selection clipboard
}
