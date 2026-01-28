#!/bin/bash

set -e

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
  htop tmux sysstat

printf "Basic command files installed successfully!\n"
