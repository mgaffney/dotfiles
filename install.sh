#!/usr/bin/env bash

# The following options are the equivalent of set -eux
# exit the script if we run into errors (-e)
#set -o errexit
# accessing an unset variable or parameter should cause an error (-u)
#set -o nounset
# print a trace of commands (-x)
# set -x xtrace

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly SCRIPTDIR

function err() {
  echo "$@" >&2
}

function backup_dir() {
  local -r src="$1"
  local -r target="${src}-orig"

  if [[ -d "${src}" ]]; then
    if [[ -d "${target}" ]]; then
      err "Error: ${target} directory already exists"
      return 1
    fi
    mv "${src}" "${target}"
  fi
}

function backup_file() {
  local -r src="$1"
  local -r target="${src}-orig"

  if [[ -f "${src}" ]]; then
    if [[ -f "${target}" ]]; then
      err "Error: ${target} file already exists"
      return 1
    fi
    mv "${src}" "${target}"
  fi
}

function backup() {
  local -r src="$1"
  if [[ -d "${src}" ]]; then
    backup_dir "${src}"
  elif [[ -f "${src}" ]]; then
    backup_file "${src}"
  fi
}

function install() {
  local -r src="$1"
  local -r target="$2"
  backup "${target}" || return
  ln -nsf "${src}" "${target}"
}

function install_tmux() {
  install "${SCRIPTDIR}/tmux/tmux.conf" "${HOME}/.tmux.conf"
}

function install_git() {
  install "${SCRIPTDIR}/git" "${HOME}/.config/git"
}

function install_alacritty() {
  install "${SCRIPTDIR}/alacritty" "${HOME}/.config/alacritty"
}

function install_zsh() {
  install "${SCRIPTDIR}/zsh/zshrc" "${HOME}/.zshrc"
}

function main() {
  mkdir -p "${HOME}/.config"
  install_tmux || return
  install_git || return
  install_alacritty || return
  install_zsh || return
}

main "$@"
