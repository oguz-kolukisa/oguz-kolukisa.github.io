#!/bin/bash

set -euo pipefail

# Check if nvm is already installed
if [ -d "$HOME/.nvm" ] && [ -s "$HOME/.nvm/nvm.sh" ]; then
  printf "nvm is already installed.\n"
  # shellcheck source=/dev/null
  . "$HOME/.nvm/nvm.sh"
  nvm --version
  exit 0
fi

NVM_FALLBACK_VERSION="v0.40.1"

printf "Installing nvm (Node Version Manager)...\n"

# Get latest nvm version tag
NVM_VERSION=$(wget -qO- https://api.github.com/repos/nvm-sh/nvm/releases/latest \
  | grep '"tag_name"' | sed 's/.*"tag_name": "\(.*\)".*/\1/')

if [ -z "$NVM_VERSION" ]; then
  NVM_VERSION="$NVM_FALLBACK_VERSION"
  printf "Could not fetch latest version, using fallback: %s\n" "$NVM_VERSION"
fi

printf "Installing nvm %s...\n" "$NVM_VERSION"
wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash \
  || { printf "Error: nvm installation script failed.\n" >&2; exit 1; }

# Source nvm to verify
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

if ! command -v nvm &>/dev/null && [ ! -s "$HOME/.nvm/nvm.sh" ]; then
  printf "Warning: nvm installation may have failed. Please check manually.\n" >&2
fi

printf "nvm installed successfully!\n"
printf "Restart your terminal or run 'source ~/.bashrc' to use nvm.\n"
printf "Then run 'nvm install --lts' to install the latest LTS Node.js.\n"
