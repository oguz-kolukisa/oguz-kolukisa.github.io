#!/bin/bash

set -e

if ! command -v gh &>/dev/null; then
  printf "Installing GitHub CLI...\n"
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg 2>/dev/null
  sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt-get update -qq
  sudo apt-get install -y gh
  printf "GitHub CLI installed successfully!\n"
else
  printf "GitHub CLI is already installed.\n"
fi

# Login to GitHub CLI only if not already authenticated
if ! gh auth status &>/dev/null; then
  printf "Starting GitHub CLI authentication...\n"
  gh auth login
else
  printf "GitHub CLI is already authenticated.\n"
fi
