#!/bin/bash

set -euo pipefail

printf "SSH Key Setup\n"
printf "=============\n"

# Check for existing keys
EXISTING_KEYS=$(ls "$HOME/.ssh/"*.pub 2>/dev/null || true)

if [ -n "$EXISTING_KEYS" ]; then
  printf "Existing SSH public keys found:\n"
  for key in $EXISTING_KEYS; do
    printf "  %s\n" "$key"
    cat "$key"
    printf "\n"
  done
  read -p "Generate a new key anyway? (y/n): " generate_new </dev/tty
  if ! [[ "$generate_new" =~ ^[Yy]$ ]]; then
    printf "Skipping key generation.\n"
    exit 0
  fi
fi

# Get email for key label
read -p "Enter your email for the SSH key label: " key_email </dev/tty
if [ -z "$key_email" ]; then
  printf "Error: Email is required for SSH key label.\n" >&2
  exit 1
fi

# Choose key type
printf "Key type options:\n"
printf "  1) ed25519 (recommended, modern)\n"
printf "  2) rsa 4096 (widely compatible)\n"
read -p "Choose key type [1/2, default 1]: " key_choice </dev/tty
key_choice="${key_choice:-1}"

KEY_FILE="$HOME/.ssh/id_ed25519"
KEY_TYPE="ed25519"
KEY_OPTS=()

if [ "$key_choice" = "2" ]; then
  KEY_FILE="$HOME/.ssh/id_rsa"
  KEY_TYPE="rsa"
  KEY_OPTS=(-b 4096)
fi

# Generate key
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

ssh-keygen -t "$KEY_TYPE" "${KEY_OPTS[@]}" -C "$key_email" -f "$KEY_FILE" -N ""

printf "\nSSH key generated: %s\n" "$KEY_FILE"
printf "\nYour public key (add this to GitHub/GitLab/servers):\n"
printf "================================\n"
cat "${KEY_FILE}.pub"
printf "================================\n"
printf "\nTo add to GitHub: https://github.com/settings/ssh/new\n"
printf "SSH key setup complete!\n"
