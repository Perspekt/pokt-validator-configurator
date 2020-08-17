#!/bin/bash

sudo apt-get update -y
sudo apt-get install golang -y
sudo apt install nginx -y
sudo apt install certbot -y
sudo apt install git -y
sudo add-apt-repository ppa:certbot/certbot -y
curl -sSL https://git.io/g-install | sh -s
echo STARTING NEW SHELL TO LOAD G-INSTALL...
sudo su - $(whoami)



