#!/bin/bash

set -euo pipefail

if command -v docker &>/dev/null; then
  printf "Docker is already installed.\n"
  docker --version
  exit 0
fi

printf "Installing Docker...\n"

# Install prerequisites
sudo apt-get update -qq
sudo apt-get install -y ca-certificates gnupg

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
wget -qO- https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
if [ ! -s /etc/apt/keyrings/docker.gpg ]; then
  printf "Error: Failed to download Docker GPG key.\n" >&2
  exit 1
fi
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
printf "deb [arch=%s signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu %s stable\n" \
  "$(dpkg --print-architecture)" \
  "$(. /etc/os-release && printf "%s" "$VERSION_CODENAME")" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update -qq
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to docker group so sudo is not required
if ! groups "$USER" | grep -q docker; then
  printf "Adding %s to the docker group...\n" "$USER"
  sudo usermod -aG docker "$USER"
  printf "Note: Log out and back in for group membership to take effect.\n"
fi

# Enable and start Docker service
sudo systemctl enable docker --quiet
sudo systemctl start docker

# Verify installation
if ! command -v docker &>/dev/null; then
  printf "Warning: Docker installation may have failed. Please check manually.\n" >&2
fi

printf "Docker installed successfully!\n"
printf "Run 'docker run hello-world' to verify (after re-login for non-sudo use).\n"
