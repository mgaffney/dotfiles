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
  tic -x "${SCRIPTDIR}/tmux/xterm-256color-italic.terminfo"
  tic -x "${SCRIPTDIR}/tmux/tmux-256color.terminfo"
}

function install_git() {
  install "${SCRIPTDIR}/git" "${HOME}/.config/git"
}

function install_zsh() {
  install "${SCRIPTDIR}/zsh/zshrc" "${HOME}/.zshrc"
}

function install_psql() {
  mkdir -p "${HOME}/.psql"
  install "${SCRIPTDIR}/psql/psqlrc" "${HOME}/.psqlrc"
}

function install_dircolors {
  local -r target="${HOME}/sandbox/dircolors-solarized"
  mkdir -p "${HOME}/sandbox"
  git clone https://github.com/mgaffney/dircolors-solarized.git "${target}" || return
  install "${target}/dircolors.ansi-universal" "${HOME}/.dircolors"
}

function install_neovim() {
  install "${SCRIPTDIR}/nvim" "${HOME}/.config/nvim"
}

function install_bat() {
  install "${SCRIPTDIR}/bat" "${HOME}/.config/bat"
}

function install_creds() {
  local -r target="${HOME}/.creds"
  mkdir -p "${target}"
  chmod 700 "${target}"
  cp -a "${SCRIPTDIR}/creds/" "${target}"
}

function install_less() {
  install "${SCRIPTDIR}/less/lessfilter" "${HOME}/.lessfilter"
}

function install_wget() {
  install "${SCRIPTDIR}/wget/wgetrc" "${HOME}/.wgetrc"
}

function set_mac_defaults() {
  defaults write com.apple.screencapture disable-shadow -bool true
}

function install_ohmyzsh() {
  if ! [[ -d "${HOME}/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

function main() {
  mkdir -p "${HOME}/.config"
  install_tmux || return
  install_git || return
  install_zsh || return
  install_ohmyzsh || return
  install_psql || return
  install_dircolors || return
  install_neovim || return
  install_creds || return
  install_bat || return
  install_less || return
  install_wget || return
  set_mac_defaults || return
}

main "$@"
