#!/bin/bash

set -e

printf "Downloading Anaconda installer...\r"
curl -fsSL https://repo.anaconda.com/archive/Anaconda3-2025.12-1-Linux-x86_64.sh -o anaconda.sh
printf "\rDownloading Anaconda installer... Done\r"

printf "Installing Anaconda...\r"
bash anaconda.sh -b -p $HOME/anaconda3
printf "Installing Anaconda... Done\r"

# Initialize conda for bash
$HOME/anaconda3/bin/conda init bash

# Remove installer after installation
rm -f anaconda.sh
printf "Removed Anaconda installer.\r"
printf "Anaconda installed. Please restart your terminal or run 'source ~/.bashrc' to activate conda.\r"
