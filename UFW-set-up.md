```
sudo apt-get install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
# sudo ufw allow 30303
# sudo ufw allow from 192.148.16.1 to any port 8545
sudo ufw allow 8081
sudo ufw allow 8082
sudo ufw allow 26657
sudo ufw allow 26658
```
