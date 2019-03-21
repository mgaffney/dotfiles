#!/usr/bin/env bash

# The following options are the equivalent of set -eux
# exit the script if we run into errors (-e)
#set -o errexit
# accessing an unset variable or parameter should cause an error (-u)
#set -o nounset
# print a trace of commands (-x)
# set -x xtrace

declare -r srcdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function err() {
  echo "$@" >&2
}

function install_git() {
  local readonly target="${HOME}/.config/git"
  if [[ -d "${target}" ]]; then
    mv "${target}" "${HOME}/.config/git-orig"
  fi
  ln -nsf "${srcdir}/git" "${target}"
}

function install_tmux() {
  local readonly target="${HOME}/.tmux.conf"
  if [[ -s "${target}" ]]; then
    mv "${target}" "${HOME}/.tmux.conf.orig"
  fi
  ln -nsf "${srcdir}/tmux/tmux.conf" "${target}"
}

function install_alacritty() {
  local readonly target="${HOME}/.config/alacritty"
  if [[ -d "${target}" ]]; then
    mv "${target}" "${HOME}/.config/alacritty-orig"
  fi
  ln -nsf "${srcdir}/alacritty" "${target}"
}

function main() {
  mkdir -p "${HOME}/.config"
  install_tmux
  install_git
  install_alacritty
}

main "$@"
