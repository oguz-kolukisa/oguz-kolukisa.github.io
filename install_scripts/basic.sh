#!/bin/bash

set -e

printf "Installing basic command files..."
sudo apt install -y -qq curl vim git 2>&1 >/dev/null
printf "\rInstalling basic command files... Done\n"
