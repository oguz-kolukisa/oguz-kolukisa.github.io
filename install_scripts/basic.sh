#!/bin/bash

set -e

echo "Installing basic command files..."
sudo apt-get update
sudo apt-get install -y \
  curl \
  vim \
  git \
  wget \
  build-essential \
  unzip \
  ca-certificates \
  gnupg \
  software-properties-common \
  apt-transport-https
echo "Installing basic command files... Done"
