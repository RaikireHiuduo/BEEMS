#!/bin/sh

# Directory setup
cd ../../
BNA=`pwd`"/beems@0.0.1.bna"
cd ./fabric/networkSetup
FABDIR=`pwd`

# Install Composer app to the network
cd ${FABDIR}
composer network start -c PeerAdmin@beems-org1 -a ${BNA} \
-o endorsementPolicyFile=${FABDIR}/endorse/endorsement-policy.json \
-A bit -C ${FABDIR}/1/bit/admin-pub.pem \
-A mimos -C ${FABDIR}/2/mimos/admin-pub.pem

# Prepare call card
cd ${FABDIR}
composer card create -p ./1/connection-org1.json -u bit -n beems -c ./1/bit/admin-pub.pem -k ./1/bit/admin-priv.pem -f ./1/bit@beems.card
composer card import -f ./1/bit@beems.card
composer network ping -c bit@beems
