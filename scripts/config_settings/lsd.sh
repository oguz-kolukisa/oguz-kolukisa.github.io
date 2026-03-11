#!/bin/bash

set -euo pipefail

# Install lsd if not already installed
if ! command -v lsd &>/dev/null; then
  printf "Installing lsd...\n"
  sudo apt-get update -qq
  sudo apt-get install -y lsd
fi

# Target file: shared config if set, else bashrc
TARGET="${OGUZ_SHELL_CONFIG:-$HOME/.bashrc}"

# Define separator markers
SEPARATOR_START="# ========== LSD CONFIG START =========="
SEPARATOR_END="# ========== LSD CONFIG END =========="

# Create the lsd configuration block
LSD_CONFIG="
$SEPARATOR_START

# lsd aliases
alias ls='lsd'
alias ll='lsd -l'
lt() {
  local depth=2
  local dir=\".\"
  while [[ \$# -gt 0 ]]; do
    case \"\$1\" in
      -d|--depth) depth=\"\$2\"; shift 2 ;;
      *) dir=\"\$1\"; shift ;;
    esac
  done
  lsd --tree --depth \"\$depth\" \"\$dir\"
}

$SEPARATOR_END
"

# Always remove old lsd configuration from bashrc (so we don't leave duplicates)
if grep -q "$SEPARATOR_START" ~/.bashrc 2>/dev/null; then
  printf "Removing old lsd configuration from ~/.bashrc...\n"
  sed -i "/$SEPARATOR_START/,/$SEPARATOR_END/d" ~/.bashrc
fi

# If writing to shared config, remove old block from that file too
if [ "$TARGET" != "$HOME/.bashrc" ] && [ -f "$TARGET" ] && grep -q "$SEPARATOR_START" "$TARGET" 2>/dev/null; then
  printf "Removing old lsd configuration from shared config...\n"
  sed -i "/$SEPARATOR_START/,/$SEPARATOR_END/d" "$TARGET"
fi

# Add new lsd configuration to target
printf "Adding lsd configuration to %s...\n" "$TARGET"
printf "%s\n" "$LSD_CONFIG" >> "$TARGET"

printf "LSD configuration complete!\n"
