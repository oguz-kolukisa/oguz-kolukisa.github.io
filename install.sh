#!/bin/bash

sudo apt install curl
sudo apt install vim
sudo apt install gh
sudo apt install git

gh auth login

curl https://repo.anaconda.com/archive/Anaconda3-2025.12-1-Linux-x86_64.sh | bash

