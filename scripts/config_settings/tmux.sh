#!/bin/bash

set -euo pipefail

# Install tmux if not already installed
if ! command -v tmux &>/dev/null; then
  printf "Installing tmux...\n"
  sudo apt-get update -qq
  sudo apt-get install -y tmux
fi

TMUX_CONF="$HOME/.tmux.conf"
MARKER="# ========== OGUZ TMUX CONFIG =========="

if grep -qF "$MARKER" "$TMUX_CONF" 2>/dev/null; then
  printf "tmux config already present. Skipping.\n"
  exit 0
fi

printf "Adding tmux configuration to %s...\n" "$TMUX_CONF"

cat >> "$TMUX_CONF" <<'EOF'
# ========== OGUZ TMUX CONFIG ==========

# Change prefix to Ctrl+a (easier to reach)
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Enable mouse support
set -g mouse on

# Start window and pane numbering at 1
set -g base-index 1
setw -g pane-base-index 1

# Renumber windows when one is closed
set -g renumber-windows on

# Increase scrollback buffer
set -g history-limit 10000

# Faster escape time (helps with vim)
set -sg escape-time 10

# True color support
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"

# Split panes with | and -
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# Navigate panes with vim keys
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Reload config with r
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

# Status bar styling
set -g status-bg colour235
set -g status-fg colour136
set -g status-left-length 40
set -g status-left '#[fg=colour2]#S #[fg=colour8]| '
set -g status-right '#[fg=colour8]| #[fg=colour136]%H:%M %d-%b'
setw -g window-status-current-style fg=colour2,bold

# ========== END ==========
EOF

printf "tmux configuration complete!\n"
printf "Run 'tmux source ~/.tmux.conf' to apply in a running session.\n"

# Add tmux shell alias to shared config
CONFIG_FILE="${OGUZ_SHELL_CONFIG:-$HOME/.config/oguz-setup/shell-config.sh}"
ALIAS_MARKER="# ========== TMUX ALIAS CONFIG START =========="

if grep -qF "$ALIAS_MARKER" "$CONFIG_FILE" 2>/dev/null; then
  printf "tmux alias config already present. Skipping.\n"
else
  printf "Adding tmux alias to %s...\n" "$CONFIG_FILE"
  cat >> "$CONFIG_FILE" <<'ALIASEOF'

# ========== TMUX ALIAS CONFIG START ==========
alias tat='tmux attach -t'
# ========== END ==========
ALIASEOF
  printf "tmux alias config added.\n"
fi
