#!/bin/sh

# Recreate the fabric network from scratch completely.
# Change the FABRIC_START_TIMEOUT to a large value if failing like 60 seconds
# Single channel, single peer.

# set the environment
export FABRIC_VERSION=hlfv1;
export FABRIC_START_TIMEOUT=30;

# constants
adminNetwork="admin@beems"
peerAdmin="PeerAdmin@hlfv1"
businessNetworkName="beems"
adminName="admin"
adminPw="adminpw"
archive="beems@0.0.1.bna"
adminNetworkCard="networkadmin.card"
devFolder="beems"

# uninstall whatever previous version of this fabric and its cards available.
./uninstall.sh

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

