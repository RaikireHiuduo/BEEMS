#!/bin/sh

# Directory setup
cd ../../
BNA=`pwd`"/beems@0.0.1.bna"
cd ./fabric/networkSetup
FABDIR=`pwd`

# Install Composer app to the network
#cd ${FABDIR}
#composer network start -c PeerAdmin@beems-org2 -a ${BNA} \
#-o endorsementPolicyFile=${FABDIR}/endorse/endorsement-policy.json \
#-A bit -C ${FABDIR}/1/bit/admin-pub.pem \
#-A mimos -C ${FABDIR}/2/mimos/admin-pub.pem

# Prepare call card
cd ${FABDIR}
composer card create -p ./2/connection-org2.json -u mimos -n beems -c ./2/mimos/admin-pub.pem -k ./2/mimos/admin-priv.pem -f ./2/mimos@beems.card
composer card import -f ./2/mimos@beems.card
composer network ping -c mimos@beems
