#!/bin/bash

set -euo pipefail

printf "Installing basic command files...\n"

# Update package cache
printf "Updating package cache...\n"
sudo apt-get update -qq

# Install packages
sudo apt-get install -y \
  curl vim git \
  cmake pkg-config \
  net-tools openssh-client nmap telnet \
  zip unzip unrar \
  htop tmux sysstat \
  lsd

# Verify installation
if ! command -v git &>/dev/null; then
  printf "Warning: git installation may have failed. Please check manually.\n" >&2
fi

printf "Basic command files installed successfully!\n"
