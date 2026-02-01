#!/bin/bash

set -euo pipefail

if command -v claude &>/dev/null; then
  printf "Claude Code is already installed.\n"
  exit 0
fi

printf "Installing Claude Code...\n"
curl -fsSL https://claude.ai/install.sh | bash

# Verify installation
if ! command -v claude &>/dev/null; then
  printf "Warning: Claude Code installation may have failed. Please check manually.\n" >&2
fi

printf "Claude Code installed successfully!\n"
