#!/bin/bash

set -euo pipefail

if command -v neofetch &>/dev/null; then
  printf "neofetch is already installed.\n"
  exit 0
fi

printf "Installing neofetch...\n"
sudo apt-get update -qq
sudo apt-get install -y neofetch

# Verify installation
if ! command -v neofetch &>/dev/null; then
  printf "Warning: neofetch installation may have failed. Please check manually.\n" >&2
fi

printf "neofetch installed successfully!\n"
