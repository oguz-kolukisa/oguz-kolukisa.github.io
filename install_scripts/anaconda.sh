#!/bin/bash

set -e

echo "Downloading Anaconda installer..."
curl -fsSL https://repo.anaconda.com/archive/Anaconda3-2025.12-1-Linux-x86_64.sh -o anaconda.sh

echo "Installing Anaconda..."
bash anaconda.sh -b -p $HOME/anaconda3

# Initialize conda for bash
$HOME/anaconda3/bin/conda init bash

# Remove installer after installation
rm -f anaconda.sh
echo "Removed Anaconda installer."
echo "Anaconda installed. Please restart your terminal or run 'source ~/.bashrc' to activate conda."
