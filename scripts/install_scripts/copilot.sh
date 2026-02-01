#!/bin/bash

set -euo pipefail

if gh copilot --version &>/dev/null; then
  printf "GitHub Copilot CLI is already installed.\n"
  exit 0
fi

printf "Installing GitHub Copilot CLI...\n"
wget -qO- https://gh.io/copilot-install | bash
printf "GitHub Copilot CLI installed successfully!\n"

# Add local bin to PATH if not already present
if ! grep -q 'export PATH="$PATH:$HOME/.local/bin"' ~/.bashrc; then
  echo "" >> ~/.bashrc
  echo "# Add local bin to PATH" >> ~/.bashrc
  echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
  printf "Added ~/.local/bin to PATH in ~/.bashrc\n"
fi

# Verify installation
if ! gh copilot --version &>/dev/null; then
  printf "Warning: GitHub Copilot CLI installation may have failed. Please check manually.\n" >&2
fi

printf "Please restart your terminal or run 'source ~/.bashrc' to use Copilot CLI.\n"
