# flexoki_dark-tmux

A clean, dark tmux theme based on [Flexoki](https://stephango.com/flexoki) colors. 

Forked from [yukinord-tmux](https://github.com/adibhanna/yukinord-tmux) which is based on [tokyo-night-tmux](https://github.com/janoamaral/tokyo-night-tmux).

## Screenshot

<img width="2560" height="48" alt="image" src="https://github.com/user-attachments/assets/99b5bbd8-13e3-485a-a815-025e44e4d2e4" />


## Installation

### Using TPM (Tmux Plugin Manager)

Add to your `~/.tmux.conf`:

```bash
set -g @plugin 'strix/flexoki_dark-tmux'
```

Then press `prefix + I` to install.

### Manual Installation

```bash
git clone https://github.com/strix/flexoki_dark-tmux.git ~/.tmux/plugins/flexoki_dark-tmux
```

Add to your `~/.tmux.conf`:

```bash
run-shell ~/.tmux/plugins/flexoki_dark-tmux/flexoki_dark.tmux
```

## Configuration

```bash
# Window/pane number styles: none, digital, roman, super, sub, dsquare, hsquare, fsquare
set -g @flexoki_dark-tmux_window_id_style digital
set -g @flexoki_dark-tmux_pane_id_style hsquare
set -g @flexoki_dark-tmux_zoom_id_style dsquare

# Session background: on or off (transparent)
set -g @flexoki_dark-tmux_session_bg "on"

# Center window list: on or off
set -g @flexoki_dark-tmux_window_center "off"

# GitHub status widget: on or off
set -g @flexoki_dark-tmux_github_status on

# Path widget (disabled by default)
set -g @flexoki_dark-tmux_show_path 1
set -g @flexoki_dark-tmux_path_format relative  # relative or full
```

## Features

- **Git Status**: Shows current branch, sync status, and change counts
- **GitHub Integration**: Displays open pull requests and issues count
  - Requires GitHub CLI (`gh`) for authenticated requests
  - Results are cached for 5 minutes
- **Custom Window Numbers**: Configurable window and pane number styles
- **Path Widget**: Shows current directory path

## Flexoki Colors

| Color   | Hex       |
|---------|-----------|
| Background | `#100f0f` |
| Foreground | `#cecdc3` |
| Red     | `#d14d41` |
| Green   | `#879a39` |
| Yellow  | `#d0a215` |
| Blue    | `#4385be` |
| Magenta | `#ce5d97` |
| Cyan    | `#3aa99f` |

## Requirements

- tmux 3.0+
- Bash 4.0+
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- `bc` for git widgets
- `gh` (GitHub CLI) for GitHub integration (optional)

## License

MIT
