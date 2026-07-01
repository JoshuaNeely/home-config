#!/bin/bash

alias weave='~/.local/bin/weave-wrapper'
alias openchamber='~/.local/bin/openchamber-wrapper'
alias ls='ls --almost-all --color=auto'
alias grep='grep --color=auto'
alias gs='git status'

# calling "tmux" tends to leave sessions hanging around
alias tmux0='tmux attach -t0'

alias vi='vim'

alias emacs="emacsclient -a ''"
alias emacsclient="emacsclient -nw"

alias open="xdg-open"

alias ssh="ssh -C -X"

rbi() {
  echo "you probably meant 'irb'"
}
