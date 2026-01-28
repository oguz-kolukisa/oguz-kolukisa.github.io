#!/bin/bash

set -e

echo "Installing basic command files..."

# Update package cache
echo "Updating package cache..."
sudo apt-get update -qq

# Install packages
sudo apt-get install -y \
  curl vim git \
  cmake pkg-config \
  net-tools openssh-client nmap telnet \
  zip unzip unrar \
  htop tmux sysstat

echo "Installing basic command files... Done"
