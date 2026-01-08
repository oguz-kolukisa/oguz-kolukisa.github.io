#!/bin/bash

# Installation script for Oguz Kolukisa's tools/setup
# Usage: curl -fsSL https://oguz-kolukisa.github.io/install.sh | bash

set -e

echo "========================================="
echo "  Oguz Kolukisa - Installation Script"
echo "========================================="
echo ""

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="Linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    OS="Windows"
else
    OS="Unknown"
fi

echo "Detected OS: $OS"
echo ""

# Check prerequisites
echo "Checking prerequisites..."

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install git first."
    exit 1
else
    echo "✅ Git is installed"
fi

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "❌ curl is not installed. Please install curl first."
    exit 1
else
    echo "✅ curl is installed"
fi

echo ""
echo "========================================="
echo "  Installation Options"
echo "========================================="
echo ""
echo "This is a template installation script."
echo "You can customize this script to:"
echo "  - Install your tools or applications"
echo "  - Clone your repositories"
echo "  - Set up development environments"
echo "  - Configure system settings"
echo ""

# Example: Ask user what they want to install
read -p "Do you want to continue with the example setup? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo ""
echo "Running example setup..."
echo ""

# Example setup commands (customize these)
echo "1. Creating example directory..."
mkdir -p ~/oguz-kolukisa-tools
cd ~/oguz-kolukisa-tools

echo "2. Example setup complete!"
echo ""

echo "========================================="
echo "  Installation Complete!"
echo "========================================="
echo ""
echo "Visit https://oguz-kolukisa.github.io for more information."
echo ""
