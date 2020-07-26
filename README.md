# pokt-validator-configurator
Scripts to setup Pocket Network validator node updated for RC-0.4.3  
(Assumes fresh Ubuntu Install logged in as root without new user)

# Instructions
## Part 1 - Create Unix User
1. git pull https://github.com/Perspekt/pokt-validator-setup.git
2. cd pokt-validator-configurator
3. chmod 755 ./*.sh
4. ./makeuser.sh
5. Enter and confirm user password
6. Press Enter 5 times to skip user info

## Part 2 - Run Dependancy Installer and Reboot
1. cd pokt-validator-configurator
2. ./dependencyinstaller.sh
3. Press Y to proceed through g-install script
4. Reboot and log back in with new user (ex. ssh newuser@1.2.3.4)

## Part 3 - Create SSL Cert
1. Run the following command and replace YourDomainName with your domain:  
sudo certbot certonly -d  YourDomainName --manual --preferred-challenges dns 
2. Enter email, Agree, Y, Y
3. Create the TXT record where your domain's nameservers are hosted

## Part 4 - Run the script to automate the Pocket-cli install and file configurations
1. git pull https://github.com/Perspekt/pokt-validator-setup.git
2. cp ~/pokt-validator-configurator/install.sh ~
3. ~/install.sh
4. Enter the domain name for your node used for Let's Encrypt SSL

## Part 5 - Create Pocket Account and Start Node
1. pocket accounts create
2. pocket accounts set-validator <address>
3. pocket start
4. Open new session
5. watch -n .5 pocket query height

