sudo apt-get install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
# sudo ufw allow 30303
sudo ufw allow 8081
sudo ufw allow 8082
sudo ufw allow 26657
sudo ufw allow 26656
