#!/bin/sh

# Starts the development app.
# Single channel, single peer.

# set the environment
export FABRIC_VERSION=hlfv1;
export FABRIC_START_TIMEOUT=15;

# constants
adminNetwork="admin@beems"
devFolder="beems"

# start network
cd ../fabric-tools
./startFabric.sh

# update
# cd ../fabric-tools
# ./downloadFabric.sh
# cd ../${devFolder}
# ./updateApp.sh

# check card
cd ../${devFolder}
composer network ping --card ${adminNetwork}

# generate REST server
composer-rest-server -c ${adminNetwork} -n never -w true
