#!/bin/bash

set -e

sudo apt update
sudo apt upgrade -y

sudo apt install -y curl vim gh git

# Login to GitHub CLI only if not already authenticated
if ! gh auth status &>/dev/null; then
  echo "GitHub CLI not authenticated. Starting 'gh auth login'..."
  gh auth login
else
  echo "GitHub CLI already authenticated."
fi

# Download Anaconda installer
curl -fsSL https://repo.anaconda.com/archive/Anaconda3-2025.12-1-Linux-x86_64.sh -o anaconda.sh

# Run installer
bash anaconda.sh

# Remove installer after installation
rm -f anaconda.sh
echo "Removed Anaconda installer."

