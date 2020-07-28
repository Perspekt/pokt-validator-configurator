# pokt-validator-configurator
Scripts to setup Pocket Network validator node updated for RC-0.4.3  
(Assumes fresh Ubuntu Install logged in as root without new user)

# Instructions
## Part 1 - Create Unix User
1. git clone https://github.com/Perspekt/pokt-validator-configurator.git
2. cd pokt-validator-configurator
3. chmod 755 ./*.sh
4. ./makeuser.sh
5. Enter and confirm user password
6. Press Enter 5 times to skip user info

## Part 2 - Run Dependancy Installer and Reboot
1. git clone https://github.com/Perspekt/pokt-validator-configurator.git
2. cd pokt-validator-configurator
3. ./dependencyinstaller.sh
4. Press Y to proceed through g-install script
5. Continue to Part 3 (you are dropped into a new shell)

## Part 3 - Create SSL Cert
1. Run the following command and replace YourDomainName with your domain:  
sudo certbot certonly -d  YourDomainName --manual --preferred-challenges dns 
2. Enter email, Agree, Y, Y
3. Create the TXT record where your domain's nameservers are hosted (wait a few minuites for propagation)
4. Go back to your terminal and "Press Enter to Continue" (You should see "Congratulations!")

## Part 4 - Run the script to automate the Pocket-cli install and file configurations
1. cp ~/pokt-validator-configurator/install.sh ~
2. ~/install.sh
3. Enter the domain name for your node used for Let's Encrypt SSL

## Part 5 - Create Pocket Account, Start Node, Stake
1. Continue here: https://docs.pokt.network/docs/create-validator-node

### Helpful Commands
- pocket query height           #Show what block you are synced to
- node01.yourDomain.com:26657/net_info?         #Shows Peers
- pocket query node <address>   #Shows status of node
