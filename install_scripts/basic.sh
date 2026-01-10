#!/bin/bash

set -e

printf "Installing basic command files..."
sudo apt install -y -qq curl vim git
printf "\rInstalling basic command files... Done\n"
