```diff
@@ DRAFT/DRAFT/DRAFT/DRAFT/DRAFT/DRAFT/DRAFT/DRAFT/DRAFT/DRAFT/DRAFT/DRAFT/DRAFT/DRAFT/DRAFT @@
@@ THIS DOCUMENT IS NOT READY FOR PUBLICATION.  USE IT ONLY IN CONCERT WITH SOMEONE WHO KNOWS HOW THIS WORKS!! @@
```
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
## Step 7 Sync the blockchain and test
7.1) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) pocket start  
```diff
- wait for it to sync the blockchain
- You can open another terminal window to the same server with the same account and type:
! pocket query height
- to see the block height progress..
- when it has synced… stop it with <control>C and restart it with:
```
7.2) ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+)pocket start --simulateRelay

7.3)  Ethereum Relay Test:
```diff
-  (replace "yourDomain.com" with the URL of your Pocket Validator Node)  
-  (replace "xxx.xxx.xxx.xxx" with the IP of an Ethereum Full Node that will accept RPCs)  
``` 
![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) ```curl -X POST --data '{"chain_url":"http://xxx.xxx.xxx.xxx:8545","payload":{"data":"{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBalance\",\"params\":[\"0xe7a24E61b2ec77d3663ec785d1110688d2A32ecc\", \"latest\"],\"id\":1}","method":"POST","path":"","headers":{}}}' https://yourDomain.com:8081/v1/client/sim ```

7.4) Pocket Relay Test
```diff
-  (replace "yourDomain.com" with the URL of your Pocket Validator Node)  
-  (replae "xxx.xxx.xxx.xxx" with the IP of a Pocket Full Node that will accept RPCs)  
``` 
![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) ```curl --insecure -X POST --data '{"chain_url":"http://xxx.xxx.xxx.xxx:8081","payload":{"data":"{}","method":"POST","path":"v1/query/nodes","headers":{}}}' https://yourDomain.com:8081/v1/client/sim ```


## Step 8 - Load Wallet



You have two options:  
1.)  copy it up using an FTP program such as filezilla.  
2.)  Create it on the server using “vi” and copy/paste the contents from your local device. 

This document will assume you are using option 2.  If you have already copied up the file using another method, skip to the line that starts…. “pocket accounts import-armored..”

vi .pocket/config/keyfile.json

1.) Open the secure keyfile on your PC with any text editor and copy the entire contents of that file.  
2.) Paste those contents into the keyfile.json which you are currently editing on the server.
3.) save the file.

NOTE: we are using the path .pocket/config for convenience and consistency… it does not have to be in that specific directory nor have that specific name. 


pocket accounts import-armored .pocket/config/keyfile.json

((enter passphrase then ))…
((enter passphrase again ))…

((Account imported successfully [LongStringOfLettersAndNumbers] ))



pocket accounts set-validator LongStringOfLettersAndNumbersFromAbove

((passphrase then no-output))

Review the chains.json just to make sure everything looks good. In particular make sure you have an entry for id: 0001 and 0021

cat .pocket/config/chains.json

now let’s start this back baby up!
In a separate terminal window. Type:

pocket start
(( Tons of red and green output ))

if stakeing with fresh pocket skip this section 
 if loading funds already in the genesis file then 
Back in the original terminal window type:

pocket nodes unjail LongStringOfLettersAndNumbersFromAbove mainnet 10000
((passphrase then….)
((may fail [code: 4 ] don’t panic.. try again in two minutes))
(( Not sure if this is a timing error or network instability))
(( 4 nodes tested.. 1=4 trys, 2=6 trys 1=1 try ))
(( one worked at first attempt ))
(( success response ends with the below ))

    "raw_log": "[{\"msg_index\":0,\"success\":true,\"log\":\"\",\"events\":[{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"unjail_validator\"}]}]}]",
    "txhash": "4EBA2A29D2CB09AFCB084BF988743092BEF912B5DD6E5D50A4A941522A05946C"
}
pocket query node LongStringOfLettersAndNumbersFromAbove
(( requires a block confirmation could take up to 15 minutes ))
(( look for…  ))
"jailed": false,


pocket query balance LongStringOfLettersAndNumbersFromAbove

(( "balance": 990000 … or some similar number ))


ALL Happy and Joy???
good.
let’s remove the secure keyfile that we created or uploaded earlier…
No point in leaving it there (it’s encrypted but still, better safe than sorry)

rm .pocket/config/keyfile.json
(( no output ))

## below this line are just some formating samples for learning github's markdown options  


```javascript
function fancyAlert(arg) {
  if(arg) {
    $.facebox({div:'#foo'})
  }
}
```

1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b
   

pocket nodes stake 56870CF8331229C762A9E9C40FE7E22C34574D71 15140000000 0001,0021 http://node5.2jx.com:8081 mainnet 10000

```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```

```diff
line one  
line two  
+ line three "green"??? +
line four
- line five "red"???
!! line six !!
```

- ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) `#f03c15`
- ![#c5f015](https://via.placeholder.com/15/c5f015/000000?text=+) `#c5f015`
- ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+X) `#1589F0`


https://placehold.it/150/ffffff/ff0000?text=hello

### ignore the text below... It is for format testing

```diff
# text in gray
next line
@@ text in purple (and bold)@@
```

- ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) `#f03c15 red'`
- ![#c5f015](https://via.placeholder.com/15/c5f015/000000?text=+) `#c5f015`
- ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) `#1589F0`
- ![#1589F0](https://via.placeholder.com/15/FFFF33/000000?text=+) `#FFFF33`
- ![#1589F0](https://via.placeholder.com/15/3399FF/000000?text=+) `#3399FF`
- ![#1589F0](https://via.placeholder.com/15/FF8C00/000000?text=+) `#FF8C00 dark orange`
- ![#1589F0](https://via.placeholder.com/15/FFA500/000000?text=+) `#FFA500`
- ![#1589F0](https://via.placeholder.com/15/FFC000/000000?text=+) `#FFC000 orange/gold`
- ![#1589F0](https://via.placeholder.com/15/32CD32/000000?text=+) `#32CD32 lime green`
- ![#1589F0](https://via.placeholder.com/15/9400D3/000000?text=+) `#9400D3 dark violet`


