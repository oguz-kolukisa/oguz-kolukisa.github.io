#!/bin/bash

set -e

echo "Installing GitHub Copilot CLI..."
wget -qO- https://gh.io/copilot-install | bash

# Add local bin to PATH if not already present
if ! grep -q 'export PATH="$PATH:$HOME/.local/bin"' ~/.bashrc; then
  echo "" >> ~/.bashrc
  echo "# Add local bin to PATH" >> ~/.bashrc
  echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
  echo "Added ~/.local/bin to PATH in ~/.bashrc"
fi

echo "Please restart your terminal or run 'source ~/.bashrc' to use Copilot CLI."
