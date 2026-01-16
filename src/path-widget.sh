#!/usr/bin/env bash

# Imports
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
. "${ROOT_DIR}/lib/coreutils-compat.sh"
. "${ROOT_DIR}/src/themes.sh"

# get value from tmux config
SHOW_PATH=$(tmux show-option -gv @flexoki_dark-tmux_show_path 2>/dev/null)
PATH_FORMAT=$(tmux show-option -gv @flexoki_dark-tmux_path_format 2>/dev/null) # full | relative
RESET="#[fg=${THEME[foreground]},bg=${THEME[background]},nobold,noitalics,nounderscore,nodim]"

# check if not enabled
if [ "${SHOW_PATH}" != "1" ]; then
  exit 0
fi

current_path="${1}"
default_path_format="relative"
PATH_FORMAT="${PATH_FORMAT:-$default_path_format}"

# check user requested format
if [[ ${PATH_FORMAT} == "relative" ]]; then
  current_path="$(echo ${current_path} | sed 's#'"$HOME"'#~#g')"
fi

echo "#[fg=${THEME[blue]},bg=default]░  ${RESET}#[bg=default]${current_path} "
