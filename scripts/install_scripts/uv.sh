#!/bin/bash

set -euo pipefail

if command -v uv &>/dev/null; then
  printf "uv is already installed.\n"
  exit 0
fi

printf "Installing uv Python package manager...\n"
wget -qO- https://astral.sh/uv/install.sh | sh || { printf "Error: uv installation script failed.\n" >&2; exit 1; }

# Verify installation (uv installs to ~/.local/bin which may not be in PATH yet)
if ! command -v uv &>/dev/null && [ ! -f "$HOME/.local/bin/uv" ]; then
  printf "Warning: uv installation may have failed. Please check manually.\n" >&2
fi

printf "uv installed successfully!\n"
printf "Run 'uv --help' to get started.\n"
printf "Note: Restart your terminal or run 'source ~/.bashrc' if uv is not found.\n"
