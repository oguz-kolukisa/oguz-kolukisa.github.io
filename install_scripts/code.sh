#!/bin/bash

set -e

# Check if code is already installed
if command -v code &>/dev/null; then
  printf "Visual Studio Code is already installed.\n"
  exit 0
fi

printf "Installing Visual Studio Code...\n"

# Create a temporary file for the GPG key
TEMP_GPG=$(mktemp)
trap "rm -f $TEMP_GPG" EXIT

# Download and install Microsoft GPG key
printf "Adding Microsoft GPG key...\n"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > "$TEMP_GPG"
sudo install -D -o root -g root -m 644 "$TEMP_GPG" /etc/apt/keyrings/packages.microsoft.gpg

# Add VS Code repository to APT sources
printf "Adding VS Code repository...\n"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

# Update package cache and install VS Code
printf "Updating package cache...\n"
sudo apt-get update

printf "Installing VS Code...\n"
sudo apt-get install -y code

printf "Visual Studio Code installed successfully!\n"
printf "You can launch it by typing 'code' in your terminal.\n"
