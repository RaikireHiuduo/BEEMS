#!/bin/sh

# Directory setup
cd ../../fabric/networkSetup
FABDIR=`pwd`

# get PB and PR
cd ${FABDIR}
PB="./crypto-config/peerOrganizations/org2.beems.com/users/Admin@org2.beems.com/msp/signcerts/Admin@org2.beems.com-cert.pem"
cd ./crypto-config/peerOrganizations/org2.beems.com/users/Admin@org2.beems.com/msp/keystore
PR="./crypto-config/peerOrganizations/org2.beems.com/users/Admin@org2.beems.com/msp/keystore/"`ls|grep *_sk`

# Create admin connection profile.
cd ${FABDIR}
composer card create -p ./2/connection-org2-only.json -u PeerAdmin -c ${PB} -k ${PR} -r PeerAdmin -r ChannelAdmin -f ./2/PeerAdmin@beems-org2-only.card
composer card create -p ./2/connection-org2.json -u PeerAdmin -c ${PB} -k ${PR} -r PeerAdmin -r ChannelAdmin -f ./2/PeerAdmin@beems-org2.card

# Import to wallet
composer card import -f ./2/PeerAdmin@beems-org2-only.card
composer card import -f ./2/PeerAdmin@beems-org2.card

# install Hyperledger Composer runtime to the network
composer runtime install -c PeerAdmin@beems-org2-only -n beems

# Keep mimos information here.
cd ${FABDIR}/2
composer identity request -c PeerAdmin@beems-org2-only -u admin -s adminpw -d mimos