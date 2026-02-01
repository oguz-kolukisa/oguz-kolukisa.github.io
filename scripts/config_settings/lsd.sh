#!/bin/bash

set -euo pipefail

# Install lsd if not already installed
if ! command -v lsd &> /dev/null; then
  printf "Installing lsd...\n"
  sudo apt-get update -qq
  sudo apt-get install -y lsd
fi

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

# Remove old lsd configuration if it exists
if grep -q "$SEPARATOR_START" ~/.bashrc; then
  printf "Removing old lsd configuration...\n"
  sed -i "/$SEPARATOR_START/,/$SEPARATOR_END/d" ~/.bashrc
fi

# Add new lsd configuration
printf "Adding lsd configuration to ~/.bashrc...\n"
echo "$LSD_CONFIG" >> ~/.bashrc

printf "LSD configuration complete!\n"
