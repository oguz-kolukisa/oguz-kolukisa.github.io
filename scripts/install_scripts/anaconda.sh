#!/bin/bash

set -euo pipefail

if command -v conda &>/dev/null; then
  printf "Anaconda is already installed.\n"
  exit 0
fi

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

printf "Downloading Anaconda installer...\n"
curl -fsSL https://repo.anaconda.com/archive/Anaconda3-2025.12-1-Linux-x86_64.sh -o "$TEMP_DIR/anaconda.sh"
printf "Download complete!\n"

printf "Installing Anaconda (this may take a few minutes)...\n"
bash "$TEMP_DIR/anaconda.sh" -b -p "$HOME/anaconda3"
printf "Installation complete!\n"

# Initialize conda for bash
printf "Initializing conda...\n"
"$HOME/anaconda3/bin/conda" init bash

# Verify installation
if ! "$HOME/anaconda3/bin/conda" --version &>/dev/null; then
  printf "Warning: Anaconda installation may have failed. Please check manually.\n" >&2
fi

printf "Anaconda installed successfully! Restart your terminal or run 'source ~/.bashrc' to activate conda.\n"
