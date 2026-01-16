#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/../lib/coreutils-compat.sh"
source "$CURRENT_DIR/themes.sh"

cd "$1" || exit 1
RESET="#[fg=${THEME[foreground]},bg=${THEME[background]},nobold,noitalics,nounderscore,nodim]"
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
STATUS=$(git status --porcelain 2>/dev/null | grep -cE "^(M| M)")

SYNC_MODE=0
NEED_PUSH=0

if [[ ${#BRANCH} -gt 25 ]]; then
  BRANCH="${BRANCH:0:25}…"
fi

STATUS_CHANGED=""
STATUS_INSERTIONS=""
STATUS_DELETIONS=""
STATUS_UNTRACKED=""

if [[ $STATUS -ne 0 ]]; then
  DIFF_COUNTS=($(git diff --numstat 2>/dev/null | awk 'NF==3 {changed+=1; ins+=$1; del+=$2} END {printf("%d %d %d", changed, ins, del)}'))
  CHANGED_COUNT=${DIFF_COUNTS[0]}
  INSERTIONS_COUNT=${DIFF_COUNTS[1]}
  DELETIONS_COUNT=${DIFF_COUNTS[2]}

  SYNC_MODE=1
fi

UNTRACKED_COUNT="$(git ls-files --other --directory --exclude-standard | wc -l | bc)"

if [[ $CHANGED_COUNT -gt 0 ]]; then
  STATUS_CHANGED="#[fg=${THEME[yellow]}] ~${CHANGED_COUNT}"
fi

if [[ $INSERTIONS_COUNT -gt 0 ]]; then
  STATUS_INSERTIONS="#[fg=${THEME[green]}] +${INSERTIONS_COUNT}"
fi

if [[ $DELETIONS_COUNT -gt 0 ]]; then
  STATUS_DELETIONS="#[fg=${THEME[red]}] -${DELETIONS_COUNT}"
fi

if [[ $UNTRACKED_COUNT -gt 0 ]]; then
  STATUS_UNTRACKED="#[fg=${THEME[cyan]}] ?${UNTRACKED_COUNT}"
fi

# Determine repository sync status
if [[ $SYNC_MODE -eq 0 ]]; then
  NEED_PUSH=$(git log @{push}.. 2>/dev/null | wc -l | bc)
  if [[ $NEED_PUSH -gt 0 ]]; then
    SYNC_MODE=2
  else
    LAST_FETCH=$(stat -c %Y .git/FETCH_HEAD 2>/dev/null | bc)
    NOW=$(date +%s | bc)

    if [[ -n "$LAST_FETCH" ]] && [[ $((NOW - LAST_FETCH)) -gt 300 ]]; then
      git fetch --atomic origin --negotiation-tip=HEAD 2>/dev/null
    fi

    REMOTE_DIFF="$(git diff --numstat "${BRANCH}" "origin/${BRANCH}" 2>/dev/null)"
    if [[ -n $REMOTE_DIFF ]]; then
      SYNC_MODE=3
    fi
  fi
fi

# Set the status indicator based on the sync mode
case "$SYNC_MODE" in
1)
  # Local changes (dirty)
  SYNC_ICON="#[fg=${THEME[red]}]●"
  ;;
2)
  # Need to push
  SYNC_ICON="#[fg=${THEME[yellow]}]↑"
  ;;
3)
  # Need to pull
  SYNC_ICON="#[fg=${THEME[magenta]}]↓"
  ;;
*)
  # Clean/synced
  SYNC_ICON="#[fg=${THEME[green]}]✓"
  ;;
esac

if [[ -n $BRANCH ]]; then
  echo "${RESET}${SYNC_ICON} #[fg=${THEME[blue]}] ${RESET}${BRANCH}${STATUS_CHANGED}${STATUS_INSERTIONS}${STATUS_DELETIONS}${STATUS_UNTRACKED} "
fi
