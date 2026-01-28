#!/bin/bash

set -e

if gh copilot --version &>/dev/null; then
  echo "GitHub Copilot CLI already installed."
  exit 0
fi

echo "Installing GitHub Copilot CLI..."
wget -qO- https://gh.io/copilot-install | bash
echo "Installing GitHub Copilot CLI... Done"

# Add local bin to PATH if not already present
if ! grep -q 'export PATH="$PATH:$HOME/.local/bin"' ~/.bashrc; then
  echo "" >> ~/.bashrc
  echo "# Add local bin to PATH" >> ~/.bashrc
  echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
  echo "Added ~/.local/bin to PATH in ~/.bashrc"
fi

echo "Please restart your terminal or run 'source ~/.bashrc' to use Copilot CLI."
