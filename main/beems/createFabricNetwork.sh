#!/bin/sh

# Recreate the fabric network from scratch completely. This assumes the .bna file is available.
# Try running createApp.sh if failing or check this shell code.
# Single channel, single peer.

# set the environment
export FABRIC_VERSION=hlfv1;
export FABRIC_START_TIMEOUT=15;

# constants
adminNetwork="admin@beems"
peerAdmin="PeerAdmin@hlfv1"
businessNetworkName="beems"
adminName="admin"
adminPw="adminpw"
archive="beems@0.0.1.bna"
adminNetworkCard="networkadmin.card"
devFolder="beems"

# remove old networdadmin.card
composer card list
composer card delete -n ${adminNetwork}
composer card delete -n ${peerAdmin}

# destroy old network
cd ../fabric-tools
./stopFabric.sh
./teardownFabric.sh

# start network
cd ../fabric-tools
./downloadFabric.sh
./createFabric.sh
./createPeerAdminCard.sh

# install and run
cd ../${devFolder}
./createApp.sh
composer runtime install --card ${peerAdmin} --businessNetworkName ${businessNetworkName}
composer network start --card ${peerAdmin} --networkAdmin ${adminName} --networkAdminEnrollSecret ${adminPw} --archiveFile ${archive} --file ${adminNetworkCard}
composer card import --file ${adminNetworkCard}
composer network ping --card ${adminNetwork}

# generate REST server
composer-rest-server -c ${adminNetwork} -n never -w true

