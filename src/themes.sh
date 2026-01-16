#!/usr/bin/env bash

# Flexoki Dark background + Yukinord (Nord) colors for tmux
# Background from Flexoki Dark to match Ghostty theme
# Accent colors from yukinord-tmux (Nord palette)

declare -A THEME=(
  # Background colors (Flexoki Dark - matches Ghostty)
  ["background"]="#100f0f"
  ["bg1"]="#100f0f"
  ["bg2"]="#1a1b1f"
  ["bg3"]="#2e3440"
  ["bg4"]="#434c5e"
  ["bg5"]="#4c566a"
  ["statusbar_bg"]="#1a1b1f"

  # Foreground colors (Yukinord/Nord)
  ["foreground"]="#eceff4"
  ["fg1"]="#e5e9f0"
  ["fg2"]="#d8dee9"
  ["fg3"]="#8d929c"
  ["fg4"]="#616e88"

  # Standard colors (Yukinord/Nord)
  ["black"]="#2e3440"
  ["white"]="#eceff4"
  ["red"]="#bf616a"
  ["green"]="#a3be8c"
  ["yellow"]="#ebcb8b"
  ["blue"]="#81a1c1"
  ["magenta"]="#b48ead"
  ["cyan"]="#88c0d0"

  # Bright variants (Yukinord/Nord)
  ["bblack"]="#434c5e"
  ["bwhite"]="#d8dee9"
  ["bred"]="#bf616a"
  ["bgreen"]="#a3be8c"
  ["byellow"]="#ebcb8b"
  ["bblue"]="#5e81ac"
  ["bmagenta"]="#b48ead"
  ["bcyan"]="#8fbcbb"

  # Additional colors (Yukinord/Nord)
  ["orange"]="#d08770"
  ["teal"]="#8fbcbb"
  ["border"]="#3b4252"
  ["gold"]="#ffd700"
)

# GitHub status colors (Yukinord)
THEME['ghgreen']="#a3be8c"
THEME['ghmagenta']="#b48ead"
THEME['ghred']="#bf616a"
THEME['ghyellow']="#ebcb8b"

RESET="#[fg=${THEME[foreground]},bg=${THEME[background]},nobold,noitalics,nounderscore,nodim]"
