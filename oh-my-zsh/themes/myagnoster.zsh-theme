# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

# HIGH_VOLTAGE_SIGN=''

# CMD_MODE_CHAR='✪'
MODE_INDICATOR="%{$fg_bold[yellow]%}✪❮%{$reset_color%}%{$fg[yellow]%}❮❮%{$reset_color%}"


CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''
RSEGMENT_SEPARATOR=''

BRANCH_CHAR=''
LINE_CHAR=''
PADLOCK_CHAR=''
BLACK_RIGHT_ARROW_CHAR=''
BLACK_LEFT_ARROW_CHAR=''
RIGHT_ARROW_CHAR=''
LEFT_ARROW_CHAR=''

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$user@%m"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty mode repo_path
  repo_path=$(command git rev-parse --git-dir 2>/dev/null)

  if $(command git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow black
    else
      prompt_segment green black
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:git:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\// }${vcs_info_msg_0_%% }${mode}"
  fi
}

prompt_hg() {
  local rev status
  if $(hg id >/dev/null 2>&1); then
    if $(hg prompt >/dev/null 2>&1); then
      if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
        # if files are not added
        prompt_segment red black
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        prompt_segment yellow black
        st='±'
      else
        # if working copy is clean
        prompt_segment green black
      fi
      echo -n $(hg prompt "☿ {rev}@{branch}") $st
    else
      st=""
      rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
      branch=$(hg id -b 2>/dev/null)
      if `hg st | grep -q "^\?"`; then
        prompt_segment red black
        st='±'
      elif `hg st | grep -q "^[MA]"`; then
        prompt_segment yellow black
        st='±'
      else
        prompt_segment green black
      fi
      echo -n "☿ $rev@$branch" $st
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  # prompt_segment blue black '%~'
  # prompt_segment blue black '%(4~|.../%3~|%~)'
  prompt_segment blue black '%(4~|…/%3~|%~)'
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment blue black "(`basename $virtualenv_path`)"
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

####

rprompt_started=''

# Start the right prompt
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
rprompt_start() {
  if [[ -n $rprompt_started ]]; then
    return
  fi

  rprompt_started="true"

  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"

  echo -n "%{%F{$1}%}$RSEGMENT_SEPARATOR%{$fg%}"

  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3

  # if [[ -n $CURRENT_BG ]]; then
  #   echo -n "%{%k%F{$CURRENT_BG}%}$RSEGMENT_SEPARATOR "
  #   # echo -n " $RSEGMENT_SEPARATOR%{%k%F{$CURRENT_BG}%}"
  # else
  #   echo -n "%{%k%}"
  # fi
  # echo -n "%{%f%}"
  # CURRENT_BG=''

}

# Begin a right segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
rprompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  [[ -n $1 ]] && nextbg="%F{$1}"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    # background is changing
      # fg = next background
      # bg is current bg
    # echo -n "%{$bg%F{$CURRENT_BG}%}$RSEGMENT_SEPARATOR%{$fg%} "
    echo -n "%{$nextbg%}$RSEGMENT_SEPARATOR%{$bg%}%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
rprompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$RSEGMENT_SEPARATOR"
    # echo -n " $RSEGMENT_SEPARATOR%{%k%F{$CURRENT_BG}%}"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# Colors: red, blue, green, cyan, yellow, magenta, black, white
aws_acct_prompt() {
	if [[ "$AWS_ACCT" == "aws-personal" ]]; then
		# rprompt_segment black red "$BLACK_LEFT_ARROW_CHAR"
		rprompt_start red black
		rprompt_segment red black "$AWS_ACCT "
		# rprompt_end
	elif [[ "$AWS_ACCT" == "aws-company" ]]; then
		rprompt_start magenta white
		rprompt_segment magenta white "$AWS_ACCT "
	# elif [[ "$AWS_ACCT" == "no-aws" || -z "${AWS_ACCT}" ]]; then
		# rprompt_start white black
		# rprompt_segment white black "$AWS_ACCT "
	else
		echo ''
	fi
}

# brmagenta (violet in solarized) FG# 95 BG# 105
# Colors: red, blue, green, cyan, yellow, magenta, black, white
local_pg_url() {
  if [[ -n "$PG_URL" ]]; then
		# rprompt_segment black red "$BLACK_LEFT_ARROW_CHAR"
		rprompt_start red black
    rprompt_segment red black "${"${PG_URL##*/}"%\?*} "
  fi
}

local_boundary_test_pg_url() {
	if [[ -n "$BOUNDARY_TESTING_PG_URL" ]]; then
		# rprompt_segment black red "$BLACK_LEFT_ARROW_CHAR"
		rprompt_start 105 black
    rprompt_segment 105 black "${"${BOUNDARY_TESTING_PG_URL##*/}"%\?*} "
  fi
}

local_xpg_url_a() {
	if [[ -n "$BOUNDARY_TESTING_PG_URL" ]]; then
		# rprompt_segment black red "$BLACK_LEFT_ARROW_CHAR"
		rprompt_start blue white
    rprompt_segment blue white "${"${BOUNDARY_TESTING_PG_URL##*/}"%\?*} "
  fi

  if [[ -n "$PG_URL" ]]; then
		# rprompt_segment black red "$BLACK_LEFT_ARROW_CHAR"
		rprompt_start red black
    rprompt_segment red black "${"${PG_URL##*/}"%\?*} "
  fi
}

# Colors: red, blue, green, cyan, yellow, magenta, black, white
local_xpg_url_b() {
	if [[ -n "$BOUNDARY_TESTING_PG_URL" ]] && [[ -n "$PG_URL" ]]; then
  fi
	if [[ -n "$BOUNDARY_TESTING_PG_URL" ]]; then
		# rprompt_segment black red "$BLACK_LEFT_ARROW_CHAR"
		rprompt_start blue white
    rprompt_segment blue white "${"${BOUNDARY_TESTING_PG_URL##*/}"%\?*} "
  elif [[ -n "$PG_URL" ]]; then
		# rprompt_segment black red "$BLACK_LEFT_ARROW_CHAR"
		rprompt_start red black
    rprompt_segment red black "${"${PG_URL##*/}"%\?*} "
	else
		echo ''
	fi
}

# function _vi_status() {
#   if {echo $fpath | grep -q "plugins/vi-mode"}; then
#     echo "$(vi_mode_prompt_info)"
#   fi
# }

# function vi_mode_prompt_info() {
#   echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
# }

function vi_mode_prompt_right() {
  # if [[ $fpath == *"plugins/vi-mode"* ]]; then
  if [[ "$fpath" =~ "plugins/vi-mode" ]]; then
		rprompt_start red black
		rprompt_segment red black "$(vi_mode_prompt_info) "
    # echo "$(vi_mode_prompt_info)"
  fi
}

function vi_mode_prompt_left() {
  if [[ "$fpath" =~ "plugins/vi-mode" ]]; then
    case $KEYMAP in
      # normal mode
      vicmd)
        prompt_segment brblue white
        echo -n "N"
        ;;
      # visual mode
      vivis|vivli)
        prompt_segment magenta white
        echo -n "V"
        ;;
      # replace mode
      virep)
        prompt_segment red black
        echo -n "R"
        ;;
      # insert mode
      main|viins|*)
        prompt_segment yellow white
        echo -n "I"
        ;;
    esac
  fi
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_context
  vi_mode_prompt_left
  prompt_dir
  prompt_git
  prompt_hg
  prompt_end
}

build_rprompt() {
  local_boundary_test_pg_url
  local_pg_url
#   prompt_status
#   prompt_virtualenv
#   prompt_context
#   vi_mode_prompt_left
#   prompt_dir
#   prompt_git
#   prompt_hg
#   prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '
# RPROMPT='%{%f%b%k%}$(aws_acct_prompt)'
# RPROMPT='%{%f%b%k%}$(local_pg_url)'
RPROMPT='%{%f%b%k%}$(build_rprompt)'
# RPROMPT='%{%f%b%k%}$(vi_mode_prompt_right)'
