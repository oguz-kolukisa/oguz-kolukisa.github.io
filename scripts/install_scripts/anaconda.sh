#!/bin/bash

set -e

if command -v conda &>/dev/null; then
  printf "Anaconda is already installed.\n"
  exit 0
fi

printf "Downloading Anaconda installer...\n"
curl -fsSL https://repo.anaconda.com/archive/Anaconda3-2025.12-1-Linux-x86_64.sh -o anaconda.sh
printf "Download complete!\n"

printf "Installing Anaconda (this may take a few minutes)...\n"
bash anaconda.sh -b -p $HOME/anaconda3
printf "Installation complete!\n"

# Initialize conda for bash
printf "Initializing conda...\n"
$HOME/anaconda3/bin/conda init bash

# Remove installer after installation
rm -f anaconda.sh
printf "Cleaned up installer file.\n"
printf "Anaconda installed successfully! Restart your terminal or run 'source ~/.bashrc' to activate conda.\n"
