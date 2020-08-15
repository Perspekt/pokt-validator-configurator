# pokt-validator-configurator
Scripts to setup Pocket Network validator node updated for RC-0.5.0  
(Assumes fresh Ubuntu Install logged in as root without new user)  
( Tested on UBUNTU VERSION 20.04 = Successfully )  
( Does not work on version 18 )  

# Instructions
## Part 1 - Create Unix User
1.1) git clone https://github.com/Perspekt/pokt-validator-configurator.git

        (( Unpacking objects: 100% (38/38), 8.96 KiB | 705.00 KiB/s, done. ))

1.2) cd pokt-validator-configurator

        (( comand prompt now ends with :~/pokt-validator-configurator#  ))

1.3 chmod 755 ./*.sh

        (( no output generated ))

1.4 ./makeuser.sh

        (( Enter name of new Unix user: )) - - enter new username
        
        (( New password: )) -- enter password

        (( Retype new password: )) -- reenter password

        (( Full Name []: )) -- hit enter to leave blank

        (( Room Number []: )) -- hit enter to leave blank

        (( Work Phone []: )) -- hit enter to leave blank

        (( Home Phone []:)) -- hit enter to leave blank

        (( Other []: )) -- hit enter to leave blank

        (( Is the information correct? [Y/n]))  - - Y

        (( command prompt now starts with the username that you just created ))


## Part 2 - Run Dependancy Installer and Reboot
2.1) git clone https://github.com/Perspekt/pokt-validator-configurator.git

        (( Unpacking objects: 100% (38/38), 8.96 KiB | 655.00 KiB/s, done.))
        
2.2) cd pokt-validator-configurator

        (( command prompt ends with :~/pokt-validator-configurator$ ))
        
2.3) ./dependencyinstaller.sh

        (( [sudo] password for nodeuser: )) - - enter password
        ((  takes aproximately 3 minutes to complete,  pauses several times durring process))
        (( several "error" and warning lines but it's OK))
        (( Do you want to continue? [y/N] )) - - Y
        (( Do you want to install the latest go version? [y/N] )) - - Y
        (( STARTING NEW SHELL TO LOAD G-INSTALL... ))

2.4) Continue to Part 3 (you are dropped into a new shell)

## Part 3 - Create SSL Cert
   [[ Run the following command and replace YourDomainName with your domain:]]  
3.1) sudo certbot certonly -d  YourDomainName --manual --preferred-challenges dns 

        (( [sudo] password for nodeuser: )) - - enter password
        (( Enter email .... (Enter 'c' to cancel): - - enter email
        (( (A)gree/(C)ancel: )) - - A
        (( (Y)es/(N)o: )) - - Y
        (( Are you OK with .... (Y)es/(N)o: )) - - Y
        ((Please deploy a DNS TXT record under the name
              _acme-challenge.node2.2jx.com with the following value:

               Before continuing, verify the record is deployed.
              - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
               Press Enter to Continue  ))
      ### STOP HERE.. do not press enter until you have confirmed the deployment of the TXT record and value.
      pocket accounts create
     https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars
      
3.2) Create the TXT record where your domain's nameservers are hosted (wait a few minuites for propagation)

        [[here are some sample tool sites to confirm that the DNS info has been propogated]]
        
      https://mxtoolbox.com/TXTLookup.aspx
      
      https://www.whatsmydns.net/

3.4) Go back to your terminal and "Press Enter to Continue" (You should see "Congratulations!")

## Part 4 - Run the script to automate the Pocket-cli install and file configurations
4.1) cp ~/pokt-validator-configurator/install.sh ~

        (( no output ))
4.2) ~/install.sh

        ((Enter domain name for node )) - - enter the domain name from above in step 3
        (( [sudo] password for nodeuser: )) - - enter password
        [[ takes about 2 minutes, pauses several times ))
        ((ends with NGINX IS RESTARTED! CONFIGURATION COMPLETE - PROCEED TO STEP 5 ]]


## Part 5 - Create Pocket Account
5.1) pocket accounts create

5.2) vi .pocket/config/chains.json

(( insert the text below ... ))  
((Change xxx.xxx.xxx.xxx for the IP of the full node which will provide relays))  

[  
  {  
    "id": "0001",  
    "url": "http://xxx.xxx.xxx.xxx:8081"  
  },  
  {  
    "id": "0021",  
    "url": "http://xxx.xxx.xxx.xxx:8545"  
  }  
]  

5.3) Continue here: https://docs.pokt.network/docs/create-validator-node

### Helpful Commands
- pocket query height           #Show what block you are synced to
- node01.yourDomain.com:26657/net_info?         #Shows Peers
- pocket query node <address>   #Shows status of node
