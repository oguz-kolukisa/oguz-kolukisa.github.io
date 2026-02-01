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
  echo "" >> ~/.bashrc
  echo "# oguz-setup: load shared shell config" >> ~/.bashrc
  echo "$SOURCE_LINE" >> ~/.bashrc
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
  echo "" >> "$CONFIG_FILE"
  echo "$PATH_MARKER" >> "$CONFIG_FILE"
  echo 'export PATH="$PATH:$HOME/.local/bin"' >> "$CONFIG_FILE"
  echo "# ========== END ==========" >> "$CONFIG_FILE"
fi

# Export so lsd.sh and tuxsay.sh write to CONFIG_FILE
export OGUZ_SHELL_CONFIG="$CONFIG_FILE"

# Download and run each config script
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

printf "Downloading config scripts...\n"
wget -q "$BASE_URL/scripts/config_settings/lsd.sh" -O "$TEMP_DIR/lsd.sh"
wget -q "$BASE_URL/scripts/config_settings/tuxsay.sh" -O "$TEMP_DIR/tuxsay.sh"
wget -q "$BASE_URL/scripts/config_settings/sudo_users.sh" -O "$TEMP_DIR/sudo_users.sh"
chmod +x "$TEMP_DIR"/lsd.sh "$TEMP_DIR"/tuxsay.sh "$TEMP_DIR"/sudo_users.sh

printf "\n--- LSD configuration ---\n"
bash "$TEMP_DIR/lsd.sh"

printf "\n--- Tuxsay configuration ---\n"
bash "$TEMP_DIR/tuxsay.sh"

printf "\n--- Sudo users / group configuration ---\n"
bash "$TEMP_DIR/sudo_users.sh"

printf "\n================================\n"
printf "All configurations installed.\n"
printf "Shell config is in: %s\n" "$CONFIG_FILE"
printf "~/.bashrc sources it automatically.\n"
printf "================================\n"
