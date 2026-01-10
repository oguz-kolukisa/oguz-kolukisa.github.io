#!/bin/bash

set -e

if ! command -v gh &>/dev/null; then
  printf "Installing GitHub CLI...\r"
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg 2>/dev/null
  sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update -qq 2>&1 >/dev/null
  sudo apt install -y -qq gh 2>&1 >/dev/null
  printf "Installing GitHub CLI... Done\r"
else
  printf "GitHub CLI already installed.\n"
fi

# Login to GitHub CLI only if not already authenticated
if ! gh auth status &>/dev/null; then
  printf "GitHub CLI not authenticated. Starting 'gh auth login'...\r"
  gh auth login
else
  printf "GitHub CLI already authenticated.\r"
fi
