#!/bin/bash

set -e

# Install lsd if not already installed
if ! command -v lsd &> /dev/null; then
  echo "Installing lsd..."
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
lt() { lsd --tree --depth \"\${1:-3}\"; }

$SEPARATOR_END
"

# Remove old lsd configuration if it exists
if grep -q "$SEPARATOR_START" ~/.bashrc; then
  echo "Removing old lsd configuration..."
  sed -i "/$SEPARATOR_START/,/$SEPARATOR_END/d" ~/.bashrc
fi

# Add new lsd configuration
echo "Adding lsd configuration to ~/.bashrc..."
echo "$LSD_CONFIG" >> ~/.bashrc

echo "LSD configuration complete!"
