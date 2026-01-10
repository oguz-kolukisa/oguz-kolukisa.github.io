#!/bin/bash

set -e

if ! command -v gh &>/dev/null; then
  echo "Installing GitHub CLI..."
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg 2>/dev/null
  sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update -qq
  sudo apt install -y -qq gh
  echo "GitHub CLI installed."
else
  echo "GitHub CLI already installed."
fi

# Login to GitHub CLI only if not already authenticated
if ! gh auth status &>/dev/null; then
  echo "GitHub CLI not authenticated. Starting 'gh auth login'..."
  gh auth login
else
  echo "GitHub CLI already authenticated."
fi
