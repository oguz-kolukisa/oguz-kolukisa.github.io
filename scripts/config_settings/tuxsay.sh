#!/bin/bash

set -euo pipefail

# Install fortune and cowsay if not already installed
if ! command -v fortune &> /dev/null; then
  printf "Installing fortune...\n"
  sudo apt-get install -y fortune-mod fortunes
fi

if ! command -v cowsay &> /dev/null; then
  printf "Installing cowsay...\n"
  sudo apt-get install -y cowsay
fi

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

# Remove old tuxsay configuration if it exists
if grep -q "$SEPARATOR_START" ~/.bashrc; then
  printf "Removing old tuxsay configuration...\n"
  sed -i "/$SEPARATOR_START/,/$SEPARATOR_END/d" ~/.bashrc
fi

# Remove old penguin configuration if it exists
if grep -q "# ========== PENGUIN CONFIG START ==========" ~/.bashrc; then
  printf "Removing old penguin configuration...\n"
  sed -i '\|# ========== PENGUIN CONFIG START ==========|,\|# ========== PENGUIN CONFIG END ==========|d' ~/.bashrc
fi

# Add new tuxsay configuration
printf "Adding fortune tuxsay configuration to ~/.bashrc...\n"
echo "$TUXSAY_CONFIG" >> ~/.bashrc

printf "Fortune Tuxsay configuration complete!\n"
