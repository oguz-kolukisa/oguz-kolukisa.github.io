#!/bin/bash

set -e

# Install fortune and cowsay if not already installed
if ! command -v fortune &> /dev/null; then
  echo "Installing fortune..."
  sudo apt install -y fortune-mod fortunes
fi

if ! command -v cowsay &> /dev/null; then
  echo "Installing cowsay..."
  sudo apt install -y cowsay
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
  echo "Removing old tuxsay configuration..."
  sed -i "/$SEPARATOR_START/,/$SEPARATOR_END/d" ~/.bashrc
fi

# Remove old penguin configuration if it exists
if grep -q "# ========== PENGUIN CONFIG START ==========" ~/.bashrc; then
  echo "Removing old penguin configuration..."
  sed -i "/# ========== PENGUIN CONFIG START ===========/,/# ========== PENGUIN CONFIG END ===========/d" ~/.bashrc
fi

# Add new tuxsay configuration
echo "Adding fortune tuxsay configuration to ~/.bashrc..."
echo "$TUXSAY_CONFIG" >> ~/.bashrc

echo "Fortune Tuxsay configuration complete!"
