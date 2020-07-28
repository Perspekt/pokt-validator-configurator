#!/bin/bash

read -p 'Enter domain name for node (ex: node01.test.com: ' DOMAIN

echo Configuring for domain: $DOMAIN

SEEDS=b3d86cd8ab4aa0cb9861cb795d8d154e685a94cf@seed1.testnet.pokt.network:20656,17ca63e4ff7535a40512c550dd0267e519cafc1a@seed2.testnet.pokt.network:21656,f99386c6d7cd42a486c63ccd80f5fbea68759cd7@seed3.testnet.pokt.network:22656

echo Seeds to be used: $SEEDS

g install 1.13
go get github.com/pokt-network/pocket-core
sudo apt-get update -y 
sudo apt-get install libleveldb-dev build-essential -y
cd go/src/github.com/pokt-network/pocket-core
git checkout tags/RC-0.4.3
echo $GOPATH

if [ -z "$GOPATH" ]
then
      echo "\$GOPATH is empty...Something is wrong!!"
      exit 1
else
      echo "\$GOPATH is set to: $GOPATH"
      echo PROCEEDING...
fi


sudo go build -tags cleveldb -o $GOPATH/bin/pocket ./app/cmd/pocket_core/main.go
sleep 2
pocket start #creates config.json
# Add kill process
sleep 2
cd ~/.pocket/config/
curl -O https://raw.githubusercontent.com/pokt-network/pocket-network-genesis/master/testnet/genesis.json
# Add  Create Chains
cd ~

CONFIG=~/.pocket/config/config.json
if [ -f "$CONFIG" ]; then
    echo "$CONFIG exists."
    echo CONTINUING...
else
    echo "$CONFIG does not exist. Exiting..."
    exit 1
fi

echo TRANSFORMING $CONFIG...

sed -i 's/\"rpc_port\":.*/\"rpc_port\": '\"8082'\",/g' $CONFIG
sed -i 's+\"remote_cli_url\":.*+\"remote_cli_url\": '\"http://localhost:8082'\",+g' $CONFIG
sed -i 's+\"Seeds\":.*+\"Seeds\": '\"$SEEDS'\",+g' $CONFIG

BASHRC=~/.bashrc
if cat $BASHRC | grep "ulimit -Sn 16384"; then
	echo ulimit setting already in $BASHRC
else
	echo Adding ulimit setting to $BASHRC...
	echo ulimit -Sn 16384 >> $BASHRC
fi

source ~/.bashrc

echo NGINX CONFIGURATION
sudo service nginx start

if sudo service nginx status | grep "running"; then
	echo NGINX IS STARTED!
#	sudo service nginx status
else
	echo "NGINX NOT STARTED OR INSTALLED (Run sudo service nginx start)"
fi
# Add Curl on localhost:80

echo POPULATING pocket-proxy.conf FILE...

sudo bash -c 'cat > /etc/nginx/sites-available/pocket-proxy.conf  <<EOF
server {
   add_header Access-Control-Allow-Origin "*";
   listen 8081 ssl;
   listen [::]:8081 ssl;
   ssl on;
   ssl_certificate /etc/letsencrypt/live/changeThis.com/fullchain.pem;
   ssl_certificate_key /etc/letsencrypt/live/changeThis.com/privkey.pem;
   access_log /var/log/nginx/reverse-access.log;
   error_log /var/log/nginx/reverse-error.log;
    location ~* ^/v1/client/(dispatch|relay|challenge|sim) {
     proxy_pass http://127.0.0.1:8082;
     add_header Access-Control-Allow-Methods "POST, OPTIONS";
     allow all;
   }
   location = /v1 {
     add_header Access-Control-Allow-Methods "GET";
     proxy_pass http://127.0.0.1:8082;
     allow all;
   }
}
EOF'

PROXY_CONF=/etc/nginx/sites-available/pocket-proxy.conf

sudo sed -i "s/changeThis.com/$DOMAIN/g" $PROXY_CONF

sudo cat $PROXY_CONF

sudo ln -s /etc/nginx/sites-available/pocket-proxy.conf /etc/nginx/sites-enabled/pocket-proxy.conf

sudo systemctl stop nginx
sudo systemctl start nginx

if sudo service nginx status | grep "running"; then
        echo NGINX IS RESTARTED!
#       sudo service nginx status
else
        echo "NGINX NOT STARTED PROPERLY"
	exit 1
fi

echo CONFIGURATION COMPLETE - PROCEED TO STEP 5


#curl https://$DOMAIN:8081/v1

