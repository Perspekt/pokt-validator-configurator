![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+)RED BOXES![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) . . . ![#1589F0](https://via.placeholder.com/15/32CD32/000000?text=+)GREEN BOXES![#1589F0](https://via.placeholder.com/15/32CD32/000000?text=+) . . .  ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+)ORANGE BOXES![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+)
```diff
-  RED BOX or text in red shows important errors/messages/warnings
+  GREEN BOX  or text in green shows terminal output 
!  ORANGE BOX or text in orange is stuff that you will type or copy paste into the terminal 
```
# pokt-validator-configurator
Scripts to setup Pocket Network validator node updated for RC-0.5.0 
```diff
- Assumes fresh Ubuntu Install logged in as root without new user  
- Tested on UBUNTU VERSION 20.04 = Successfully  
- Does not work on version 18  
```
# Part One - Create a Pocket Full Node
## Step 1 - Create Unix User
1.1) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+)
git clone https://github.com/BenVanGithub/pokt-validator-configurator.git
```diff
+  Unpacking objects: 100% (38/38), 8.96 KiB | 705.00 KiB/s, done.
```
1.2) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) cd pokt-validator-configurator  
comand prompt now ends with
```diff
+ :~/pokt-validator-configurator#  
```
1.3  ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) chmod 755 ./*.sh  
        (( no output generated ))  
1.4  ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) ./makeuser.sh
```diff
+ Enter name of new Unix user:  
! enter new username
+ New password: 
! enter password
+ Retype new password:
! enter password
+ Full Name []: 
! hit enter to leave blank
+ Room Number []:
! hit enter to leave blank
+ Work Phone []: 
! hit enter to leave blank
+ Home Phone []:  
! hit enter to leave blank
+ Other []: 
! hit enter to leave blank
+ Is the information correct? [Y/n]
!  Y 
+ (( command prompt now starts with the username that you just created ))
```
## Step 2 - Run Dependancy Installer and Reboot
2.1)  ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) git clone https://github.com/BenVanGithub/pokt-validator-configurator.git
```diff
+      Unpacking objects: 100% (38/38), 8.96 KiB | 655.00 KiB/s, done.
```        
2.2)  ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) cd pokt-validator-configurator
```diff
+        (( command prompt ends with :~/pokt-validator-configurator$ ))
```        
2.3)  ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) ./dependencyinstaller.sh
```diff
+[sudo] password for nodeuser:
! enter password
- takes aproximately 3 minutes to complete,  pauses several times durring process
- several "error" and warning lines but it's OK
+ Do you want to continue? [y/N] 
! Y
+ Do you want to install the latest go version? [y/N] 
! Y
+ STARTING NEW SHELL TO LOAD G-INSTALL...
```
2.4) Continue to Part 3 (you are dropped into a new shell)

## Step 3 - Create SSL Cert


```diff
- [[ Run the following command and replace YourDomainName with your domain:]]  
```
3.1) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) sudo certbot certonly -d  YourDomainName --manual --preferred-challenges dns 
```diff
+[sudo] password for nodeuser:
!enter password
+Enter email .... (Enter 'c' to cancel):
!enter email
+ (A)gree/(C)ancel: )) 
! A
+ (Y)es/(N)o: )) 
! Y
+ Are you OK with .... (Y)es/(N)o: 
! Y
- STOP.. STOP.. STOP
- The "A" record for your domain and a "TXT" record with the name and values
- shown on your screen must be deployed and propogated across the internet
- before continuing
+        ((Please deploy a DNS TXT record under the name
+              _acme-challenge.YourDomainName.com with the following value:
+
+               Before continuing, verify the record is deployed.
+              - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
+               Press Enter to Continue  ))
- STOP.. STOP.. STOP do not press enter until you have confirmed the deployment of the TXT record and value.
- reference information for how to move name servers and checking TXT propagation
``` 
  https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars
  https://mxtoolbox.com/TXTLookup.aspx
  https://www.whatsmydns.net/
    
![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+)3.2) Create the TXT record where your domain's nameservers are hosted (wait and confirm propagation)

![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+)3.4) Go back to your terminal and "Press Enter to Continue" (You should see "Congratulations!")

## Step 4 - Run the script to automate the Pocket-cli install and file configurations
4.1)  ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) cp ~/pokt-validator-configurator/install.sh ~

        (( no output ))
4.2)  ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) ~/install.sh
```diff
+ Enter domain name for node 
! enter the domain name from above in step 3
+ [sudo] password for nodeuser: 
! enter password
- takes about 3 minutes, pauses several times
- ends with:
+ NGINX IS RESTARTED! CONFIGURATION COMPLETE - PROCEED TO STEP 5
```

## Step 5 - Create Pocket Account and Sync the Node
5.1) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) pocket accounts create
```diff
+ Passphrase
- we use a simple passphrase here because this account will not have any money in it.
! emptyaddress
+ Account generated successfully:
+ Address: LongStringOfLettersAndNumbers

! 5.2) Close the current terminal session
! 5.3) Reconnect to your node
```
5.4) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) pocket start

## Whoot, Whoot you have a working full node!
```diff
-  If you wish to continue forward and convert your node into a Validator go to:
```
6.0) https://github.com/BenVanGithub/pokt-validator-configurator/blob/master/README_2.md

### Helpful Commands
- pocket query height           #Show what block you are synced to
- node01.yourDomain.com:26657/net_info?         #Shows Peers
- pocket query node <address>   #Shows status of node
