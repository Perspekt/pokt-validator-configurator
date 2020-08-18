##  Instructions for loading an existing wallet from a secure json keyfile  
##  and using that address to stake a validator on Pocket’s Mainnet.


###                     PREREQUISITES AND ASSUMPTIONS:
These instructions continue from: https://github.com/BenVanGithub/pokt-validator-configurator/blob/master/README.md   
Please be sure you have completed those steps before continuing here. 



## Step 6 Create Validator
6.1) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) pocket accounts list 
```diff
- you should see only one account, the one that you created in step 5.1
```
6.2) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) pocket accounts set-validator <address from 6.1 above>
```diff
+ Passphrase
! emptyaddress
```
## Step 7 Create chains.json (describes what blockchains you will serve and how)
7.1) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) vi .pocket/config/chains.json
```diff
- insert the text below:  
- Change xxx.xxx.xxx.xxx for the IPs of the full nodes which will provide relays 
```
```
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
```
## Step 8 Test your ability to send relays
```diff
- If Pocket is currently running... Stop it
```
8.1) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) pocket start --simulateRelay

8.2)  Ethereum Relay Test:
```diff
-  (replace "yourDomain.com" with the URL of your Pocket Validator Node)  
-  (replace "xxx.xxx.xxx.xxx" with the IP of an Ethereum Full Node that will accept RPCs)  
``` 
![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) ```curl -X POST --data '{"chain_url":"http://xxx.xxx.xxx.xxx:8545","payload":{"data":"{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBalance\",\"params\":[\"0xe7a24E61b2ec77d3663ec785d1110688d2A32ecc\", \"latest\"],\"id\":1}","method":"POST","path":"","headers":{}}}' https://yourDomain.com:8081/v1/client/sim ```
``` diff
+ produces a short response (about 40 chars) if successful
```
8.3) Pocket Relay Test
```diff
-  (replace "yourDomain.com" with the URL of your Pocket Validator Node)  
-  (replae "xxx.xxx.xxx.xxx" with the IP of a Pocket Full Node that will accept RPCs)  
``` 
![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) ```curl --insecure -X POST --data '{"chain_url":"http://xxx.xxx.xxx.xxx:8081","payload":{"data":"{}","method":"POST","path":"v1/query/nodes","headers":{}}}' https://yourDomain.com:8081/v1/client/sim ```
``` diff
+ produces a massive wall of text if successful
```
8.4) Stop the node control-C

## Step 9 - Load Wallet and Import Key

You have two options:  
1.)  copy it up using an FTP program such as filezilla.  
2.)  Create it on the server using “vi” and copy/paste the contents from your local device. 
```diff
- This document will assume you are using option 2.  
- If you have already copied up the file using another method, skip to 9.2
```
9.1) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) vi .pocket/config/keyfile.json  
![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+)9.1.1) Open the secure keyfile on your PC with any text editor and copy the entire contents of that file.  
![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+)9.1.2) Paste those contents into the keyfile.json which you are currently editing on the server.  
![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+)9.1.3) save the file.
```diff
@@ NOTE: we are using the path .pocket/config for convenience and consistency…  @@
@@ it does not have to be in that specific directory nor have that specific name. @@
```

9.2) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) pocket accounts import-armored .pocket/config/keyfile.json
```diff
+passphrase
!<<EnterYourPassphrase>>
+passphrase
!<<EnterYourPassphrase>> again
+ Account imported successfully [LongStringOfLettersAndNumbers] 
- This is your Validator-Address to be used below and for future refrence
```
## Step 10 Set the Validator address and Restart the node

10.1) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) pocket accounts set-validator < Validator-Address >
```diff
+passphrase
!<<EnterYourPassphrase>>
```
10.2) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) pocket start

## Step 11 Stake the node
```diff
- if you are using funds from the genesis block, you are already staked.
- Skip to step 12
```
11.1) ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Building the stake commad.. ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+).
```diff
@@  Step 11 is still under construction                                  @@
@@  refer to the instructions at the official Pocket developers web-site @@
```
## Step 12 Unjail (only necessary for Genesis file funding)
```diff
- change "<validator address>" to the actual Validator address from 10.1
```
12.1 )![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) pocket nodes unjail < validator address > mainnet 10000
 ```diff 
+ passphrase
! enter passphrase
  
- may fail [code: 4 ] don’t panic.. try again go to 12.1
- may take several attempts (6 is my personal record :-)  /
- Not sure if this is a timing error or network instability.

- successful response ends with json output similar too

+    "raw_log": "[{\"msg_index\":0,\"success\":true,\"log\":\"\",\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"unjail_validator\"}]}]}]",
+    "txhash": "4EBA2A29D2CB09AFCB084BF988743092BEF912B5DD6E5D50A4A941522A05946C"
```
12.2 Verify that you have been let out of jail

![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) pocket query node < validator address >
  ```diff
- requires a block confirmation before success...could take up to 15 minutes
- when successful output contains...
+ "jailed": false,
```
## Step 13  Happy and Joy... We Be Validating!.. Let's clean up a bit.
let’s remove the secure keyfile that we created or uploaded earlier… 
No point in leaving it there (it’s encrypted but still, better safe than sorry)
13.1) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) rm .pocket/config/keyfile.json
(( no output ))

