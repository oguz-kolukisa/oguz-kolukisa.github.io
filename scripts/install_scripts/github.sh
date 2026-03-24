#!/bin/bash

set -euo pipefail

if ! command -v gh &>/dev/null; then
  printf "Installing GitHub CLI...\n"
  wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg 2>/dev/null
  if [ ! -s /usr/share/keyrings/githubcli-archive-keyring.gpg ]; then
    printf "Error: Failed to download GitHub CLI GPG key.\n" >&2
    exit 1
  fi
  sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
  printf "deb [arch=%s signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main\n" "$(dpkg --print-architecture)" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt-get update -qq
  sudo apt-get install -y gh
  printf "GitHub CLI installed successfully!\n"
else
  printf "GitHub CLI is already installed.\n"
fi

# Verify installation
if ! command -v gh &>/dev/null; then
  printf "Warning: GitHub CLI installation may have failed. Please check manually.\n" >&2
fi

# Login to GitHub CLI only if not already authenticated
if ! gh auth status &>/dev/null; then
  printf "Starting GitHub CLI authentication...\n"
  gh auth login
else
  printf "GitHub CLI is already authenticated.\n"
fi
