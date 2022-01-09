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
