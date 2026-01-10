#!/bin/bash

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update -qq
sudo apt upgrade -y -qq

# Ask to install basic command files
read -p "Do you want to install basic command files (curl, vim, git)? (y/n): " install_basics
if [[ "$install_basics" =~ ^[Yy]$ ]]; then
  bash "$SCRIPT_DIR/install_scripts/basic.sh"
else
  echo "Skipping basic command files installation."
fi

# Ask to install GitHub CLI
read -p "Do you want to install GitHub CLI (gh)? (y/n): " install_gh
if [[ "$install_gh" =~ ^[Yy]$ ]]; then
  bash "$SCRIPT_DIR/install_scripts/github.sh"
  
  # Ask to install GitHub Copilot CLI
  read -p "Do you want to install GitHub Copilot CLI? (y/n): " install_copilot
  if [[ "$install_copilot" =~ ^[Yy]$ ]]; then
    bash "$SCRIPT_DIR/install_scripts/copilot.sh"
  else
    echo "Skipping GitHub Copilot CLI installation."
  fi
else
  echo "Skipping GitHub CLI installation."
fi

# Ask to install Anaconda
read -p "Do you want to install Anaconda? (y/n): " install_anaconda
if [[ "$install_anaconda" =~ ^[Yy]$ ]]; then
  bash "$SCRIPT_DIR/install_scripts/anaconda.sh"
else
  echo "Skipping Anaconda installation."
fi

# Apply penguin configuration
bash "$SCRIPT_DIR/config_settings/penguin.sh"

