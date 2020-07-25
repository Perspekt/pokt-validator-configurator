#!/bin/bash

read -p 'Enter name of new Unix user: ' USER

echo Creating new user: $USER

adduser $USER
usermod -aG sudo $USER
cp -r /root/.ssh /home/$USER/.ssh
chown -R ${USER}:${USER} /home/$USER/.ssh
cp -rf $(pwd) /home/$USER/
ls -la /home/$USER
su - $USER
