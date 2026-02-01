#!/bin/bash

set -euo pipefail

# Installs the `grpadd` shell function into the shell config.
# grpadd -u user1,user2 -g sudo,docker

# Target file: shared config if set, else bashrc
TARGET="${OGUZ_SHELL_CONFIG:-$HOME/.bashrc}"

# Define separator markers
SEPARATOR_START="# ========== GRPADD CONFIG START =========="
SEPARATOR_END="# ========== GRPADD CONFIG END =========="

# Create the grpadd configuration block
GRPADD_CONFIG="
$SEPARATOR_START

# grpadd: add users to groups
# Usage: grpadd -u user1,user2 -g sudo,docker
grpadd() {
  local users=\"\" groups=\"\"
  OPTIND=1
  while getopts \"u:g:h\" opt; do
    case \"\$opt\" in
      u) users=\"\${OPTARG//,/ }\" ;;
      g) groups=\"\${OPTARG//,/ }\" ;;
      h)
        printf \"Usage: grpadd -u user1,user2,... -g group1,group2,...\n\"
        printf \"  -u  Comma-separated list of usernames\n\"
        printf \"  -g  Comma-separated list of groups\n\"
        printf \"  -h  Show this help message\n\"
        return 0
        ;;
      *)
        printf \"Usage: grpadd -u user1,user2,... -g group1,group2,...\n\" >&2
        return 1
        ;;
    esac
  done
  if [ -z \"\$users\" ] || [ -z \"\$groups\" ]; then
    printf \"Error: Both -u and -g are required.\n\" >&2
    printf \"Usage: grpadd -u user1,user2,... -g group1,group2,...\n\" >&2
    return 1
  fi
  local group user
  for group in \$groups; do
    if ! getent group \"\$group\" &>/dev/null; then
      printf \"Creating group '%s'...\n\" \"\$group\"
      sudo groupadd \"\$group\" 2>/dev/null || true
    fi
  done
  for user in \$users; do
    if ! id \"\$user\" &>/dev/null; then
      printf \"Warning: User '%s' does not exist. Skipping.\n\" \"\$user\" >&2
      continue
    fi
    for group in \$groups; do
      if getent group \"\$group\" | grep -q \"\\\b\$user\\\b\"; then
        printf \"User '%s' already in group '%s'.\n\" \"\$user\" \"\$group\"
      else
        printf \"Adding user '%s' to group '%s'...\n\" \"\$user\" \"\$group\"
        sudo usermod -aG \"\$group\" \"\$user\"
      fi
    done
  done
  printf \"Done. Users may need to log out and back in for group changes to take effect.\n\"
}

$SEPARATOR_END
"

# Remove legacy sudo-users markers from bashrc
if grep -q "# ========== SUDO USERS CONFIG START ==========" ~/.bashrc 2>/dev/null; then
  printf "Removing old sudo-users configuration from ~/.bashrc...\n"
  sed -i '/# ========== SUDO USERS CONFIG START ==========/,/# ========== SUDO USERS CONFIG END ==========/d' ~/.bashrc
fi

# Always remove old grpadd configuration from bashrc
if grep -q "$SEPARATOR_START" ~/.bashrc 2>/dev/null; then
  printf "Removing old grpadd configuration from ~/.bashrc...\n"
  sed -i "/$SEPARATOR_START/,/$SEPARATOR_END/d" ~/.bashrc
fi

# If writing to shared config, remove old block from that file too
if [ "$TARGET" != "$HOME/.bashrc" ] && [ -f "$TARGET" ] && grep -q "$SEPARATOR_START" "$TARGET" 2>/dev/null; then
  printf "Removing old grpadd configuration from shared config...\n"
  sed -i "/$SEPARATOR_START/,/$SEPARATOR_END/d" "$TARGET"
fi

# Add new grpadd configuration to target
printf "Adding grpadd configuration to %s...\n" "$TARGET"
echo "$GRPADD_CONFIG" >> "$TARGET"

printf "grpadd configuration complete!\n"
