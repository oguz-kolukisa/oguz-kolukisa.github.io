#!/bin/bash

set -e

if command -v claude &>/dev/null; then
  printf "Claude Code is already installed.\n"
  exit 0
fi

printf "Installing Claude Code...\n"
curl -fsSL https://claude.ai/install.sh | bash
printf "Claude Code installed successfully!\n"
