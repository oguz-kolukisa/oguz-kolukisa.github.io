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
TEMP_DIR=$(mktemp -d)
SCRIPT_DIR="$TEMP_DIR"
mkdir -p "$SCRIPT_DIR/install_scripts/ai"
trap 'rm -rf "$TEMP_DIR"' EXIT

# Helper: download and validate a script
_dl() {
  local src="$1" dest="$2"
  wget -q "$BASE_URL/$src" -O "$dest"
  if [ ! -s "$dest" ]; then
    printf "Error: Failed to download %s\n" "$src" >&2
    exit 1
  fi
}

# Helper: prompt user and run a script if accepted
prompt_and_run() {
  local prompt_text="$1"
  local script_path="$2"
  local skip_label="$3"
  local answer

  if [ "$AUTO_YES" = true ]; then
    answer="y"
  else
    read -p "$prompt_text (y/n): " answer </dev/tty
  fi

  if [[ "$answer" =~ ^[Yy]$ ]]; then
    bash "$script_path"
  else
    printf "Skipping %s.\n" "$skip_label"
  fi
}

# Download install scripts
printf "Downloading installation scripts...\n"
_dl "scripts/install_scripts/basic.sh"          "$SCRIPT_DIR/install_scripts/basic.sh"
_dl "scripts/install_scripts/github.sh"         "$SCRIPT_DIR/install_scripts/github.sh"
_dl "scripts/install_scripts/ai/copilot.sh"     "$SCRIPT_DIR/install_scripts/ai/copilot.sh"
_dl "scripts/install_scripts/ai/cursor.sh"      "$SCRIPT_DIR/install_scripts/ai/cursor.sh"
_dl "scripts/install_scripts/ai/claude.sh"      "$SCRIPT_DIR/install_scripts/ai/claude.sh"
_dl "scripts/install_scripts/anaconda.sh"       "$SCRIPT_DIR/install_scripts/anaconda.sh"
_dl "scripts/install_scripts/uv.sh"             "$SCRIPT_DIR/install_scripts/uv.sh"
_dl "scripts/install_scripts/code.sh"           "$SCRIPT_DIR/install_scripts/code.sh"
_dl "scripts/install_scripts/neovim.sh"         "$SCRIPT_DIR/install_scripts/neovim.sh"
_dl "scripts/install_scripts/docker.sh"         "$SCRIPT_DIR/install_scripts/docker.sh"
_dl "scripts/install_scripts/nvm.sh"            "$SCRIPT_DIR/install_scripts/nvm.sh"
_dl "scripts/install_scripts/neofetch.sh"       "$SCRIPT_DIR/install_scripts/neofetch.sh"
printf "Download complete!\n"

chmod +x "$SCRIPT_DIR/install_scripts/"*.sh "$SCRIPT_DIR/install_scripts/ai/"*.sh

printf "\nUpdating system packages...\n"
sudo apt-get update -qq >/dev/null 2>&1
sudo apt-get upgrade -y -qq >/dev/null 2>&1
printf "System packages updated!\n"

prompt_and_run "Do you want to install basic command files (curl, vim, git)?" \
  "$SCRIPT_DIR/install_scripts/basic.sh" "basic command files installation"

prompt_and_run "Do you want to install GitHub CLI (gh)?" \
  "$SCRIPT_DIR/install_scripts/github.sh" "GitHub CLI installation"

printf "\n--- AI Coding Assistants ---\n"

prompt_and_run "Do you want to install Cursor agent CLI?" \
  "$SCRIPT_DIR/install_scripts/ai/cursor.sh" "Cursor installation"

prompt_and_run "Do you want to install Claude Code (AI coding assistant)?" \
  "$SCRIPT_DIR/install_scripts/ai/claude.sh" "Claude Code installation"

prompt_and_run "Do you want to install GitHub Copilot CLI?" \
  "$SCRIPT_DIR/install_scripts/ai/copilot.sh" "GitHub Copilot CLI installation"

printf "\n--- Python Package Managers ---\n"

prompt_and_run "Do you want to install Anaconda?" \
  "$SCRIPT_DIR/install_scripts/anaconda.sh" "Anaconda installation"

prompt_and_run "Do you want to install uv (fast Python package manager)?" \
  "$SCRIPT_DIR/install_scripts/uv.sh" "uv installation"

prompt_and_run "Do you want to install Visual Studio Code?" \
  "$SCRIPT_DIR/install_scripts/code.sh" "Visual Studio Code installation"

prompt_and_run "Do you want to install Neovim?" \
  "$SCRIPT_DIR/install_scripts/neovim.sh" "Neovim installation"

prompt_and_run "Do you want to install Docker?" \
  "$SCRIPT_DIR/install_scripts/docker.sh" "Docker installation"

prompt_and_run "Do you want to install nvm (Node Version Manager)?" \
  "$SCRIPT_DIR/install_scripts/nvm.sh" "nvm installation"

prompt_and_run "Do you want to install neofetch (system info display)?" \
  "$SCRIPT_DIR/install_scripts/neofetch.sh" "neofetch installation"

# Apply all configurations via single config installer
printf "\n--- Configurations ---\n"
TEMP_CONFIG="$TEMP_DIR/install_all_configs.sh"
_dl "scripts/config_settings/install_all_configs.sh" "$TEMP_CONFIG"
chmod +x "$TEMP_CONFIG"
bash "$TEMP_CONFIG"

printf "\n"
printf "================================\n"
printf "Installation complete!\n"
printf "================================\n"
