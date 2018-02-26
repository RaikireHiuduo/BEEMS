#!/bin/sh

# Directory setup
cd ../../fabric/networkSetup
FABDIR=`pwd`

# get PB and PR
cd ${FABDIR}
PB="./crypto-config/peerOrganizations/org1.beems.com/users/Admin@org1.beems.com/msp/signcerts/Admin@org1.beems.com-cert.pem"
cd ./crypto-config/peerOrganizations/org1.beems.com/users/Admin@org1.beems.com/msp/keystore
PR="./crypto-config/peerOrganizations/org1.beems.com/users/Admin@org1.beems.com/msp/keystore/"`ls|grep *_sk`

# Create admin connection profile.
cd ${FABDIR}
composer card create -p ./1/connection-org1-only.json -u PeerAdmin -c ${PB} -k ${PR} -r PeerAdmin -r ChannelAdmin -f ./1/PeerAdmin@beems-org1-only.card
composer card create -p ./1/connection-org1.json -u PeerAdmin -c ${PB} -k ${PR} -r PeerAdmin -r ChannelAdmin -f ./1/PeerAdmin@beems-org1.card

# Import to wallet
composer card import -f ./1/PeerAdmin@beems-org1-only.card
composer card import -f ./1/PeerAdmin@beems-org1.card

# install Hyperledger Composer runtime to the network
composer runtime install -c PeerAdmin@beems-org1-only -n beems

# Keep bit information here.
cd ${FABDIR}/1
composer identity request -c PeerAdmin@beems-org1-only -u admin -s adminpw -d bit