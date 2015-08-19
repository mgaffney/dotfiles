#!/usr/bin/env bash

# The following options are the equivalent of set -eux
# exit the script if we run into errors (-e)
set -o errexit
# accessing an unset variable or parameter should cause an error (-u)
set -o nounset
# print a trace of commands (-x)
# set -x xtrace

#  Trap non-normal exit signals: 1/HUP, 2/INT, 3/QUIT, 15/TERM, ERR
trap founderror 1 2 3 15 ERR

founderror() {
  exit 1
}

exitscript() {
  exit 0
}

##
# warn: Print a message to stderr.
# Usage: warn "message"
#
warn() {
  printf 'warning: %s\n' "$@" >&2
}

##
# die: Print a message to stderr and exit with 
# status code 1
# Usage: some_command || die "message" 
#        some_command && die "message" 
#
die() {
  warn "$1"
  founderror
} 

install_git() {
  local readonly target=~/.config/git
  [[ -e $target ]] && die "$target already exists" 
  mkdir -p ~/.config
  ln -nsf "$srcdir/git" $target
}

install_tmux() {
  ln -nsf "$srcdir/tmux/tmux.conf" $HOME/.tmux.conf
}

declare -r srcdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

install_tmux
install_git

exitscript
