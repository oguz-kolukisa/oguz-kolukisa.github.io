#!/bin/bash

set -e

# Check if code is already installed
if command -v code &>/dev/null; then
  echo "Visual Studio Code is already installed."
  exit 0
fi

echo "Installing Visual Studio Code..."

# Download and install Microsoft GPG key
echo "Adding Microsoft GPG key..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
rm -f packages.microsoft.gpg

# Add VS Code repository to APT sources
echo "Adding VS Code repository..."
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

# Update package cache and install VS Code
echo "Updating package cache..."
sudo apt-get update

echo "Installing VS Code..."
sudo apt-get install -y code

echo "Visual Studio Code installed successfully!"
echo "You can launch it by typing 'code' in your terminal."
