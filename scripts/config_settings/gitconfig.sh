#!/bin/bash

set -euo pipefail

printf "Configuring git...\n"

# Prompt for user info
printf "Git global configuration\n"
printf "========================\n"

read -p "Enter your git user name (leave blank to skip): " git_name </dev/tty
read -p "Enter your git email (leave blank to skip): " git_email </dev/tty

if [ -n "$git_name" ]; then
  git config --global user.name "$git_name"
  printf "Set user.name = %s\n" "$git_name"
fi

if [ -n "$git_email" ]; then
  git config --global user.email "$git_email"
  printf "Set user.email = %s\n" "$git_email"
fi

# Set sensible defaults
git config --global init.defaultBranch main
git config --global core.editor vim
git config --global pull.rebase false
git config --global push.autoSetupRemote true
git config --global core.autocrlf input
git config --global color.ui auto

# Useful aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.unstage "reset HEAD --"
git config --global alias.last "log -1 HEAD"

printf "\nGit configuration applied:\n"
printf "  init.defaultBranch = main\n"
printf "  core.editor        = vim\n"
printf "  pull.rebase        = false\n"
printf "  push.autoSetupRemote = true\n"
printf "  Aliases: st, co, br, lg, unstage, last\n"
printf "\nGit configuration complete!\n"
