#!/bin/bash

set -e

# Create the penguin drawing function
PENGUIN_FUNC='
# Penguin drawing function
print_penguin() {
<<EOC;
   $thoughts
    $thoughts
        .--.
       |o_o |
       |:_/ |
      //   \\ \\
     (|     | )
    /'\\_   _/`\\
    \\___)=(___/

EOC
}
'

# Add penguin function to bashrc if not already present
if ! grep -q "print_penguin()" ~/.bashrc; then
  echo "" >> ~/.bashrc
  echo "# Penguin drawing function" >> ~/.bashrc
  echo "$PENGUIN_FUNC" >> ~/.bashrc
  echo "Added penguin function to ~/.bashrc"
fi

# Add penguin to be printed on terminal startup
if ! grep -q "# Print penguin on startup" ~/.bashrc; then
  echo "" >> ~/.bashrc
  echo "# Print penguin on startup" >> ~/.bashrc
  echo "print_penguin" >> ~/.bashrc
  echo "Added penguin startup call to ~/.bashrc"
fi

# Create clear alias that prints penguin
if ! grep -q 'alias clear=' ~/.bashrc; then
  echo "" >> ~/.bashrc
  echo "# Clear command with penguin" >> ~/.bashrc
  echo 'alias clear="command clear && print_penguin"' >> ~/.bashrc
  echo "Added clear alias with penguin to ~/.bashrc"
fi

echo "Penguin configuration complete!"
