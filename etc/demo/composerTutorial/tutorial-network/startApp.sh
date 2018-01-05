#!/bin/sh

# Starts the app.

# start the fabric
cd ../fabric-tools
./startFabric.sh

# remove old networdadmin.card
composer card list
composer card delete -n admin@tutorial-network

# install and run
cd ../tutorial-network
composer runtime install --card PeerAdmin@hlfv1 --businessNetworkName tutorial-network
composer network start --card PeerAdmin@hlfv1 --networkAdmin admin --networkAdminEnrollSecret adminpw --archiveFile tutorial-network@0.0.1.bna --file networkadmin.card
composer card import --file networkadmin.card
composer network ping --card admin@tutorial-network

# generate REST server
composer-rest-server -c admin@tutorial-network -n never -w true
