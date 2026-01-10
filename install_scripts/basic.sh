#!/bin/bash

set -e

printf "Installing basic command files...\r"
sudo apt-get install -y -qq curl vim git 2>&1 >/dev/null
printf "Installing basic command files... Done\r"
