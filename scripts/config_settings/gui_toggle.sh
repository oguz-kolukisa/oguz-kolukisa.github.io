#!/bin/bash

set -euo pipefail

# Target file: shared config if set, else bashrc
CONFIG_FILE="${OGUZ_SHELL_CONFIG:-$HOME/.config/oguz-setup/shell-config.sh}"

MARKER="# ========== GUI TOGGLE CONFIG START =========="

# Skip if already configured
if grep -qF "$MARKER" "$CONFIG_FILE" 2>/dev/null; then
  printf "GUI toggle aliases already present. Skipping.\n"
  exit 0
fi

printf "Adding GUI toggle aliases...\n"

cat >> "$CONFIG_FILE" <<'EOF'

# ========== GUI TOGGLE CONFIG START ==========

# Stop the desktop GUI (frees GPU/CPU resources for SSH work)
alias stop-gui='sudo systemctl isolate multi-user.target && sudo systemctl set-default multi-user.target && printf "GUI stopped. Will boot to CLI on next restart.\n"'

# Start the desktop GUI
alias start-gui='sudo systemctl set-default graphical.target && sudo systemctl isolate graphical.target && printf "GUI started. Will boot to desktop on next restart.\n"'

# ========== END ==========
EOF

printf "GUI toggle aliases added (stop-gui, start-gui).\n"
