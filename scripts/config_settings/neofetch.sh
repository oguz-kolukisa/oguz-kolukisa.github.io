#!/bin/bash

set -euo pipefail

# Install neofetch if not already installed
if ! command -v neofetch &>/dev/null; then
  printf "Installing neofetch...\n"
  sudo apt-get update -qq
  sudo apt-get install -y neofetch
fi

# Target file: shared config if set, else bashrc
TARGET="${OGUZ_SHELL_CONFIG:-$HOME/.bashrc}"

MARKER="# ========== NEOFETCH CONFIG START =========="

if grep -qF "$MARKER" "$TARGET" 2>/dev/null; then
  printf "neofetch config already present. Skipping.\n"
  exit 0
fi

printf "Adding neofetch startup config to %s...\n" "$TARGET"

cat >> "$TARGET" <<'EOF'
# ========== NEOFETCH CONFIG START ==========

# Show system info on terminal startup
if command -v neofetch &>/dev/null; then
  neofetch
fi

# ========== END ==========
EOF

printf "neofetch configuration complete!\n"
printf "neofetch will now run on every new terminal session.\n"
