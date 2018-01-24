#!/bin/sh

# constants
adminNetwork="admin@beems"
peerAdmin="PeerAdmin@hlfv1"

# remove old networdadmin.card
composer card list
composer card delete -n ${adminNetwork}
composer card delete -n ${peerAdmin}

# destroy old network
cd ../fabric-tools
./stopFabric.sh
./teardownFabric.sh
