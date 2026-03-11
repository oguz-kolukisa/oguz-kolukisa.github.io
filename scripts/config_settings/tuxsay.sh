#!/bin/bash

set -euo pipefail

# Update apt cache once if any package is missing
if ! command -v fortune &>/dev/null || ! command -v cowsay &>/dev/null; then
  sudo apt-get update -qq
fi

# Install fortune and cowsay if not already installed
if ! command -v fortune &>/dev/null; then
  printf "Installing fortune...\n"
  sudo apt-get install -y fortune-mod fortunes
fi

if ! command -v cowsay &>/dev/null; then
  printf "Installing cowsay...\n"
  sudo apt-get install -y cowsay
fi

# Target file: shared config if set, else bashrc
TARGET="${OGUZ_SHELL_CONFIG:-$HOME/.bashrc}"

# Define separator markers
SEPARATOR_START="# ========== TUXSAY CONFIG START =========="
SEPARATOR_END="# ========== TUXSAY CONFIG END =========="

# Create the tuxsay configuration block
TUXSAY_CONFIG="
$SEPARATOR_START

# Fortune Tuxsay function
fortune_tuxsay() {
  fortune -a | cowsay -f tux
}

# Print fortune tuxsay on startup
fortune_tuxsay

# Clear command with fortune tuxsay
alias clear=\"command clear && fortune_tuxsay\"

$SEPARATOR_END
"

# Always remove old tuxsay and penguin configuration from bashrc
if grep -q "$SEPARATOR_START" ~/.bashrc 2>/dev/null; then
  printf "Removing old tuxsay configuration from ~/.bashrc...\n"
  sed -i "/$SEPARATOR_START/,/$SEPARATOR_END/d" ~/.bashrc
fi
if grep -q "# ========== PENGUIN CONFIG START ==========" ~/.bashrc 2>/dev/null; then
  printf "Removing old penguin configuration from ~/.bashrc...\n"
  sed -i '\|# ========== PENGUIN CONFIG START ==========|,\|# ========== PENGUIN CONFIG END ==========|d' ~/.bashrc
fi

# If writing to shared config, remove old block from that file too
if [ "$TARGET" != "$HOME/.bashrc" ] && [ -f "$TARGET" ]; then
  if grep -q "$SEPARATOR_START" "$TARGET" 2>/dev/null; then
    printf "Removing old tuxsay configuration from shared config...\n"
    sed -i "/$SEPARATOR_START/,/$SEPARATOR_END/d" "$TARGET"
  fi
fi

# Add new tuxsay configuration to target
printf "Adding fortune tuxsay configuration to %s...\n" "$TARGET"
printf "%s\n" "$TUXSAY_CONFIG" >> "$TARGET"

printf "Fortune Tuxsay configuration complete!\n"
