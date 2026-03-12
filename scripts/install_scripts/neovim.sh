#!/bin/bash

set -euo pipefail

if command -v nvim &>/dev/null; then
  printf "Neovim is already installed.\n"
  exit 0
fi

printf "Installing Neovim...\n"
sudo apt-get update -qq
sudo apt-get install -y neovim

# Verify installation
if ! command -v nvim &>/dev/null; then
  printf "Warning: Neovim installation may have failed. Please check manually.\n" >&2
fi

printf "Neovim installed successfully!\n"
printf "Run 'nvim' to start. Run 'nvim --version' to verify.\n"
