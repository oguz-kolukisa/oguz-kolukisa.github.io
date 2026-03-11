#!/bin/bash

set -euo pipefail

# Cursor agent CLI (official install script)
if command -v cursor &>/dev/null; then
  printf "Cursor is already installed.\n"
  exit 0
fi

printf "Installing Cursor (official install script)...\n"
wget -qO- https://cursor.com/install | bash || { printf "Error: Cursor installation script failed.\n" >&2; exit 1; }

if ! command -v cursor &>/dev/null; then
  printf "Warning: Cursor may not be in PATH. Restart your terminal or run 'source ~/.bashrc'.\n" >&2
fi

printf "Cursor installed successfully!\n"
printf "Run 'cursor' in your terminal to use the Cursor agent.\n"
