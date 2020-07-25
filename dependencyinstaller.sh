#!/bin/bash

#read -p 'Enter domain for node: ' DOMAIN

#echo Domain to be used for node: $DOMAIN


sudo apt-get update -y
sudo apt-get install golang -y
sudo apt install nginx -y
sudo apt install certbot -y
sudo add-apt-repository ppa:certbot/certbot -y
curl -sSL https://git.io/g-install | sh -s

echo EXIT SHELL OR REBOOT...RE-LOGIN AND CONTINUE


