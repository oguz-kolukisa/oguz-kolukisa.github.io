#!/bin/bash

set -euo pipefail

# Parse command line arguments
AUTO_YES=false
while getopts "y" opt; do
  case $opt in
    y)
      AUTO_YES=true
      ;;
    \?)
      printf "Invalid option: -%s\n" "$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Base URL for downloading scripts
BASE_URL="https://oguz-kolukisa.github.io"

# Create temporary directory for scripts
printf "Downloading installation scripts...\n"
TEMP_DIR=$(mktemp -d)
SCRIPT_DIR="$TEMP_DIR"
mkdir -p "$SCRIPT_DIR/install_scripts/ai"

# Download install scripts only (config is applied via single config installer at the end)
wget -q "$BASE_URL/scripts/install_scripts/basic.sh" -O "$SCRIPT_DIR/install_scripts/basic.sh"
wget -q "$BASE_URL/scripts/install_scripts/github.sh" -O "$SCRIPT_DIR/install_scripts/github.sh"
wget -q "$BASE_URL/scripts/install_scripts/ai/copilot.sh" -O "$SCRIPT_DIR/install_scripts/ai/copilot.sh"
wget -q "$BASE_URL/scripts/install_scripts/ai/cursor.sh" -O "$SCRIPT_DIR/install_scripts/ai/cursor.sh"
wget -q "$BASE_URL/scripts/install_scripts/ai/claude.sh" -O "$SCRIPT_DIR/install_scripts/ai/claude.sh"
wget -q "$BASE_URL/scripts/install_scripts/anaconda.sh" -O "$SCRIPT_DIR/install_scripts/anaconda.sh"
wget -q "$BASE_URL/scripts/install_scripts/code.sh" -O "$SCRIPT_DIR/install_scripts/code.sh"
printf "Download complete!\n"

chmod +x "$SCRIPT_DIR/install_scripts/"*.sh "$SCRIPT_DIR/install_scripts/ai/"*.sh

# Cleanup function to remove temp directory on exit
trap 'rm -rf "$TEMP_DIR"' EXIT

printf "\nUpdating system packages...\n"
sudo apt-get update -qq >/dev/null 2>&1
sudo apt-get upgrade -y -qq >/dev/null 2>&1
printf "System packages updated!\n"

# Ask to install basic command files
if [ "$AUTO_YES" = true ]; then
  install_basics="y"
else
  read -p "Do you want to install basic command files (curl, vim, git)? (y/n): " install_basics </dev/tty
fi
if [[ "$install_basics" =~ ^[Yy]$ ]]; then
  bash "$SCRIPT_DIR/install_scripts/basic.sh"
else
  printf "Skipping basic command files installation.\n"
fi

# Ask to install GitHub CLI
if [ "$AUTO_YES" = true ]; then
  install_gh="y"
else
  read -p "Do you want to install GitHub CLI (gh)? (y/n): " install_gh </dev/tty
fi
if [[ "$install_gh" =~ ^[Yy]$ ]]; then
  bash "$SCRIPT_DIR/install_scripts/github.sh"
else
  printf "Skipping GitHub CLI installation.\n"
fi

# --- AI Coding Assistants (Cursor, Claude Code, Copilot CLI) ---
printf "\n--- AI Coding Assistants ---\n"

if [ "$AUTO_YES" = true ]; then
  install_cursor="y"
else
  read -p "Do you want to install Cursor agent CLI? (y/n): " install_cursor </dev/tty
fi
if [[ "$install_cursor" =~ ^[Yy]$ ]]; then
  bash "$SCRIPT_DIR/install_scripts/ai/cursor.sh"
else
  printf "Skipping Cursor installation.\n"
fi

if [ "$AUTO_YES" = true ]; then
  install_claude="y"
else
  read -p "Do you want to install Claude Code (AI coding assistant)? (y/n): " install_claude </dev/tty
fi
if [[ "$install_claude" =~ ^[Yy]$ ]]; then
  bash "$SCRIPT_DIR/install_scripts/ai/claude.sh"
else
  printf "Skipping Claude Code installation.\n"
fi

if [ "$AUTO_YES" = true ]; then
  install_copilot="y"
else
  read -p "Do you want to install GitHub Copilot CLI? (y/n): " install_copilot </dev/tty
fi
if [[ "$install_copilot" =~ ^[Yy]$ ]]; then
  bash "$SCRIPT_DIR/install_scripts/ai/copilot.sh"
else
  printf "Skipping GitHub Copilot CLI installation.\n"
fi

# Ask to install Anaconda
if [ "$AUTO_YES" = true ]; then
  install_anaconda="y"
else
  read -p "Do you want to install Anaconda? (y/n): " install_anaconda </dev/tty
fi
if [[ "$install_anaconda" =~ ^[Yy]$ ]]; then
  bash "$SCRIPT_DIR/install_scripts/anaconda.sh"
else
  printf "Skipping Anaconda installation.\n"
fi

# Ask to install VS Code
if [ "$AUTO_YES" = true ]; then
  install_code="y"
else
  read -p "Do you want to install Visual Studio Code? (y/n): " install_code </dev/tty
fi
if [[ "$install_code" =~ ^[Yy]$ ]]; then
  bash "$SCRIPT_DIR/install_scripts/code.sh"
else
  printf "Skipping Visual Studio Code installation.\n"
fi

# Apply all configurations (LSD, Tuxsay, grpadd) via single config installer
printf "\n--- Configurations ---\n"
TEMP_CONFIG=$(mktemp)
wget -q "$BASE_URL/scripts/config_settings/install_all_configs.sh" -O "$TEMP_CONFIG"
chmod +x "$TEMP_CONFIG"
bash "$TEMP_CONFIG"
rm -f "$TEMP_CONFIG"

printf "\n"
printf "================================\n"
printf "Installation complete!\n"
printf "================================\n"
