#!/bin/bash

set -euo pipefail

# Add a list of users to a list of groups (e.g. user1 user2 -> sudo docker).
# Usage: run this script; pass users and groups via env or prompts.
#   SUDO_USERS="user1 user2 user3" SUDO_GROUPS="sudo docker" ./sudo_users.sh
# Or run interactively and enter space-separated users and groups.

if [ -n "${SUDO_USERS:-}" ] && [ -n "${SUDO_GROUPS:-}" ]; then
  USERS="$SUDO_USERS"
  GROUPS="$SUDO_GROUPS"
else
  printf "Enter users to add (space-separated, e.g. user1 user2 user3): "
  read -r USERS
  printf "Enter groups to add them to (space-separated, e.g. sudo docker): "
  read -r GROUPS
fi

if [ -z "$USERS" ] || [ -z "$GROUPS" ]; then
  printf "Error: Both users and groups must be non-empty.\n" >&2
  exit 1
fi

for group in $GROUPS; do
  if ! getent group "$group" &>/dev/null; then
    printf "Creating group '%s'...\n" "$group"
    sudo groupadd "$group" 2>/dev/null || true
  fi
done

for user in $USERS; do
  if ! id "$user" &>/dev/null; then
    printf "Warning: User '%s' does not exist. Skipping.\n" "$user" >&2
    continue
  fi
  for group in $GROUPS; do
    if getent group "$group" | grep -q "\b$user\b"; then
      printf "User '%s' already in group '%s'.\n" "$user" "$group"
    else
      printf "Adding user '%s' to group '%s'...\n" "$user" "$group"
      sudo usermod -aG "$group" "$user"
    fi
  done
done

printf "Done. Users may need to log out and back in for group changes to take effect.\n"
