#!/bin/bash

set -e

if gh copilot --version &>/dev/null; then
  printf "GitHub Copilot CLI already installed.\r"
  exit 0
fi

printf "Installing GitHub Copilot CLI...\r"
wget -qO- https://gh.io/copilot-install | bash 2>&1 >/dev/null
printf "\rInstalling GitHub Copilot CLI... Done\r"

# Add local bin to PATH if not already present
if ! grep -q 'export PATH="$PATH:$HOME/.local/bin"' ~/.bashrc; then
  echo "" >> ~/.bashrc
  echo "# Add local bin to PATH" >> ~/.bashrc
  echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
  printf "Added ~/.local/bin to PATH in ~/.bashrc\r"
fi

printf "Please restart your terminal or run 'source ~/.bashrc' to use Copilot CLI.\r"
