#!/bin/bash

set -e

# Define separator markers
SEPARATOR_START="# ========== PENGUIN CONFIG START =========="
SEPARATOR_END="# ========== PENGUIN CONFIG END =========="

# Create the penguin configuration block
PENGUIN_CONFIG="
$SEPARATOR_START

# Penguin drawing function
print_penguin() {
  cat <<EOC;
        .--.
       |o_o |
       |:_/ |
      //   \ \\
     (|     | )
    /'\_   _/`\\
    \\___)=(___/

  EOC 

}

# Print penguin on startup
print_penguin

# Clear command with penguin
alias clear=\"command clear && print_penguin\"

$SEPARATOR_END
"

# Remove old penguin configuration if it exists
if grep -q "$SEPARATOR_START" ~/.bashrc; then
  echo "Removing old penguin configuration..."
  sed -i "/$SEPARATOR_START/,/$SEPARATOR_END/d" ~/.bashrc
fi

# Add new penguin configuration
echo "Adding penguin configuration to ~/.bashrc..."
echo "$PENGUIN_CONFIG" >> ~/.bashrc

echo "Penguin configuration complete!"
