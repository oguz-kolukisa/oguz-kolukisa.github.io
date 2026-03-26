#!/bin/bash

set -euo pipefail

BASE_URL="https://oguz-kolukisa.github.io"
CONFIG_DIR="${HOME}/.config/oguz-setup"
CONFIG_FILE="${CONFIG_DIR}/shell-config.sh"
SOURCE_LINE="[ -f \"${CONFIG_FILE}\" ] && . \"${CONFIG_FILE}\""

# Create config directory and file
mkdir -p "$CONFIG_DIR"
touch "$CONFIG_FILE"

# Add source line to bashrc if not present
if ! grep -qF "oguz-setup/shell-config.sh" ~/.bashrc 2>/dev/null; then
  printf "Adding source line to ~/.bashrc...\n"
  printf "\n" >> ~/.bashrc
  printf "# oguz-setup: load shared shell config\n" >> ~/.bashrc
  printf "%s\n" "$SOURCE_LINE" >> ~/.bashrc
fi

# Remove old config blocks from bashrc (so all config lives in shell-config.sh)
# LSD block
if grep -q "# ========== LSD CONFIG START ==========" ~/.bashrc 2>/dev/null; then
  printf "Removing old LSD config from ~/.bashrc...\n"
  sed -i '/# ========== LSD CONFIG START ==========/,/# ========== LSD CONFIG END ==========/d' ~/.bashrc
fi
# Tuxsay block
if grep -q "# ========== TUXSAY CONFIG START ==========" ~/.bashrc 2>/dev/null; then
  printf "Removing old Tuxsay config from ~/.bashrc...\n"
  sed -i '/# ========== TUXSAY CONFIG START ==========/,/# ========== TUXSAY CONFIG END ==========/d' ~/.bashrc
fi
# Penguin block (legacy)
if grep -q "# ========== PENGUIN CONFIG START ==========" ~/.bashrc 2>/dev/null; then
  printf "Removing old Penguin config from ~/.bashrc...\n"
  sed -i '\|# ========== PENGUIN CONFIG START ==========|,\|# ========== PENGUIN CONFIG END ==========|d' ~/.bashrc
fi
# Local bin PATH (moved to shell-config.sh)
if grep -q "# Add local bin to PATH" ~/.bashrc 2>/dev/null; then
  printf "Removing old local bin PATH from ~/.bashrc...\n"
  sed -i '/# Add local bin to PATH/d' ~/.bashrc
  sed -i '\|export PATH=.*\.local/bin|d' ~/.bashrc
fi

# Add PATH for .local/bin to shell-config.sh if not present
PATH_MARKER="# ========== OGUZ LOCAL BIN PATH =========="
if ! grep -qF "$PATH_MARKER" "$CONFIG_FILE" 2>/dev/null; then
  printf "Adding .local/bin to PATH in shared config...\n"
  printf "\n" >> "$CONFIG_FILE"
  printf "%s\n" "$PATH_MARKER" >> "$CONFIG_FILE"
  printf 'export PATH="$PATH:$HOME/.local/bin"\n' >> "$CONFIG_FILE"
  printf "# ========== END ==========\n" >> "$CONFIG_FILE"
fi

# Export so lsd.sh and tuxsay.sh write to CONFIG_FILE
export OGUZ_SHELL_CONFIG="$CONFIG_FILE"

# Download and run each config script
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# Helper: download and validate a config script
_dl_config() {
  local script_name="$1"
  local dest="$TEMP_DIR/$script_name"
  wget -q "$BASE_URL/scripts/config_settings/$script_name" -O "$dest"
  if [ ! -s "$dest" ]; then
    printf "Error: Failed to download %s\n" "$script_name" >&2
    exit 1
  fi
  chmod +x "$dest"
}

printf "Downloading config scripts...\n"
_dl_config "lsd.sh"
_dl_config "tuxsay.sh"
_dl_config "sudo_users.sh"
_dl_config "tmux.sh"
_dl_config "gitconfig.sh"
_dl_config "vimconfig.sh"
_dl_config "gui_toggle.sh"

printf "\n--- LSD configuration ---\n"
bash "$TEMP_DIR/lsd.sh"

printf "\n--- Tuxsay configuration ---\n"
bash "$TEMP_DIR/tuxsay.sh"

printf "\n--- grpadd shell function ---\n"
bash "$TEMP_DIR/sudo_users.sh"

printf "\n--- tmux configuration ---\n"
bash "$TEMP_DIR/tmux.sh"

printf "\n--- git configuration ---\n"
bash "$TEMP_DIR/gitconfig.sh"

printf "\n--- vim configuration ---\n"
bash "$TEMP_DIR/vimconfig.sh"

printf "\n--- GUI toggle aliases ---\n"
bash "$TEMP_DIR/gui_toggle.sh"

printf "\n================================\n"
printf "All configurations installed.\n"
printf "Shell config is in: %s\n" "$CONFIG_FILE"
printf "~/.bashrc sources it automatically.\n"
printf "================================\n"
