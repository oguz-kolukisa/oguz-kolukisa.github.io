#!/bin/bash

set -e

sudo apt update -qq
sudo apt upgrade -y -qq

# Ask to install basic command files
read -p "Do you want to install basic command files (curl, vim, git)? (y/n): " install_basics
if [[ "$install_basics" =~ ^[Yy]$ ]]; then
  sudo apt install -y -qq curl vim git
  echo "Basic command files installed."
else
  echo "Skipping basic command files installation."
fi

# Ask to install GitHub CLI
read -p "Do you want to install GitHub CLI (gh)? (y/n): " install_gh
if [[ "$install_gh" =~ ^[Yy]$ ]]; then
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
  
  # Ask to install GitHub Copilot CLI
  read -p "Do you want to install GitHub Copilot CLI? (y/n): " install_copilot
  if [[ "$install_copilot" =~ ^[Yy]$ ]]; then
    echo "Installing GitHub Copilot CLI..."
    wget -qO- https://gh.io/copilot-install | bash
    
    # Add local bin to PATH if not already present
    if ! grep -q 'export PATH="$PATH:$HOME/.local/bin"' ~/.bashrc; then
      echo "" >> ~/.bashrc
      echo "# Add local bin to PATH" >> ~/.bashrc
      echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
      echo "Added ~/.local/bin to PATH in ~/.bashrc"
    fi
    
    echo "Please restart your terminal or run 'source ~/.bashrc' to use Copilot CLI."
  else
    echo "Skipping GitHub Copilot CLI installation."
  fi
else
  echo "Skipping GitHub CLI installation."
fi

# Ask to install Anaconda
read -p "Do you want to install Anaconda? (y/n): " install_anaconda
if [[ "$install_anaconda" =~ ^[Yy]$ ]]; then
  # Download Anaconda installer
  curl -fsSL https://repo.anaconda.com/archive/Anaconda3-2025.12-1-Linux-x86_64.sh -o anaconda.sh
  
  # Run installer in batch mode with automatic yes
  bash anaconda.sh -b -p $HOME/anaconda3
  
  # Initialize conda for bash
  $HOME/anaconda3/bin/conda init bash
  
  # Remove installer after installation
  rm -f anaconda.sh
  echo "Removed Anaconda installer."
  echo "Anaconda installed. Please restart your terminal or run 'source ~/.bashrc' to activate conda."
else
  echo "Skipping Anaconda installation."
fi

