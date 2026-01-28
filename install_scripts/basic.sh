#!/bin/bash

set -e

# Core packages (always installed)
CORE_PACKAGES=("curl" "vim" "git")

# Optional packages with descriptions
declare -A OPTIONAL_PACKAGES
OPTIONAL_PACKAGES=(
  ["wget"]="Alternative tool for downloading files from the web"
  ["build-essential"]="Essential build tools (gcc, g++, make) for compiling software"
  ["unzip"]="Utility for extracting ZIP archives"
  ["ca-certificates"]="Common CA certificates for SSL/TLS connections"
  ["gnupg"]="GNU Privacy Guard - for encryption and signing"
  ["software-properties-common"]="Tools for managing software repositories and PPAs"
  ["apt-transport-https"]="Allows apt to retrieve packages via HTTPS"
)

echo "=========================================="
echo "Basic Development Tools Installation"
echo "=========================================="
echo ""
echo "Core packages (will be installed automatically):"
echo "  - curl: Command-line tool for transferring data"
echo "  - vim: Powerful text editor"
echo "  - git: Version control system"
echo ""
echo "Optional packages available:"
echo ""

# Display optional packages (sorted for consistency)
mapfile -t PACKAGE_NAMES < <(printf '%s\n' "${!OPTIONAL_PACKAGES[@]}" | sort)
for i in "${!PACKAGE_NAMES[@]}"; do
  pkg="${PACKAGE_NAMES[$i]}"
  echo "  $((i+1)). ${pkg}: ${OPTIONAL_PACKAGES[$pkg]}"
done

echo ""
echo "=========================================="
echo ""
read -p "Do you want to install all optional packages? (y/n): " install_all

PACKAGES_TO_INSTALL=("${CORE_PACKAGES[@]}")

if [[ "$install_all" =~ ^[Yy]$ ]]; then
  # Install all packages (use sorted PACKAGE_NAMES for consistency)
  for pkg in "${PACKAGE_NAMES[@]}"; do
    PACKAGES_TO_INSTALL+=("$pkg")
  done
  echo "Installing all packages..."
else
  # Ask for individual selections
  echo ""
  echo "Select packages to install (enter numbers separated by spaces, or 'n' to skip):"
  read -p "Your selection: " selection
  
  if [[ -z "$selection" ]]; then
    echo "No input provided. Installing core packages only."
  elif [[ "$selection" =~ ^[Nn]$ ]]; then
    echo "No optional packages selected. Installing core packages only."
  else
    valid_selection=false
    invalid_entries=()
    for num in $selection; do
      if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "${#PACKAGE_NAMES[@]}" ]; then
        idx=$((num-1))
        PACKAGES_TO_INSTALL+=("${PACKAGE_NAMES[$idx]}")
        valid_selection=true
      else
        invalid_entries+=("$num")
      fi
    done
    
    if [ "${#invalid_entries[@]}" -gt 0 ]; then
      echo "Warning: Ignoring invalid selections: ${invalid_entries[*]}"
    fi
    
    if [ "$valid_selection" = false ]; then
      echo "No valid selections made. Installing core packages only."
    fi
  fi
fi

echo ""
echo "Updating package lists..."
sudo apt-get update || echo "Warning: apt-get update failed, but continuing with installation..."

echo ""
echo "Installing selected packages: ${PACKAGES_TO_INSTALL[*]}"
sudo apt-get install -y "${PACKAGES_TO_INSTALL[@]}"

echo ""
echo "=========================================="
echo "Installation complete!"
echo "=========================================="
