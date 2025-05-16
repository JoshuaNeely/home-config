# paths relative to a repo installation of rbenv
# this ensured a more up to date version of the tool than what apt provides (on our work-version of ubuntu)
# alternatively maybe I should just update /etc/apt/sources.list.d/...
# https://askubuntu.com/questions/671757/newer-package-from-repository-of-other-ubuntu-version
export PATH="/home/jneely/git/sandbox/rbenv/bin:${PATH}"
export PATH="/home/jneely/.rbenv/shims:${PATH}"
export RBENV_SHELL=bash


_rbenv() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(rbenv commands)" -- "$word") )
  else
    local words=("${COMP_WORDS[@]}")
    unset "words[0]"
    unset "words[$COMP_CWORD]"
    local completions=$(rbenv completions "${words[@]}")
    COMPREPLY=( $(compgen -W "$completions" -- "$word") )
  fi
}
complete -F _rbenv rbenv


command rbenv rehash 2>/dev/null

rbenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}
