#!/bin/bash

# install on ubuntu 18.04
echo "install docker on Ubuntu 18.04"
# remove old version
sudo apt remove docker docker-engine docker.io
# install docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt update -y
sudo apt upgrade -y
sudo apt-cache policy docker-ce
sudo apt install -y docker-ce 

# boot docker
sudo systemctl enable docker
sudo systemctl status docker
# sudo usermod -aG docker ${USER}