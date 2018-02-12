#!/bin/bash

# SPDX-License-Identifier: Apache-2.0

# --------------------------------------------------
# Certificates and artifacts

# Generates Org certs using cryptogen tool
function generateCerts (){
  which cryptogen
  if [ "$?" -ne 0 ]; then
    echo "cryptogen tool not found. exiting"
    exit 1
  fi

  echo
  echo "##########################################################"
  echo "##### Generate certificates using cryptogen tool #########"
  echo "##########################################################"

  if [ -d "crypto-config" ]; then
    rm -Rf crypto-config
  fi

  cryptogen generate --config=./crypto-config.yaml

  if [ "$?" -ne 0 ]; then
    echo "Failed to generate certificates..."
    exit 1
  fi

  echo
}

# Generate orderer genesis block,
# channel configuration transaction, and
# anchor peer update transactions
function generateChannelArtifacts() {
  which configtxgen
  if [ "$?" -ne 0 ]; then
    echo "configtxgen tool not found. exiting"
    exit 1
  fi

  echo "##########################################################"
  echo "#########  Generating Orderer Genesis block ##############"
  echo "##########################################################"
  configtxgen -profile BEEMSOrdererGenesis -outputBlock \
  ./channel-artifacts/genesis.block
  if [ "$?" -ne 0 ]; then
    echo "Failed to generate orderer genesis block..."
    exit 1
  fi

  echo
  echo "#################################################################"
  echo "### Generating channel configuration transaction 'channel.tx' ###"
  echo "#################################################################"
  configtxgen -profile BEEMSOrgsChannel -outputCreateChannelTx \
  ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
  if [ "$?" -ne 0 ]; then
    echo "Failed to generate channel configuration transaction..."
    exit 1
  fi

  echo
  echo "#################################################################"
  echo "#######    Generating anchor peer update for bitMSP   ##########"
  echo "#################################################################"
  configtxgen -profile BEEMSOrgsChannel -outputAnchorPeersUpdate \
  ./channel-artifacts/bitMSPanchors.tx -channelID $CHANNEL_NAME -asOrg bitMSP
  if [ "$?" -ne 0 ]; then
    echo "Failed to generate anchor peer update for bitMSP..."
    exit 1
  fi

  echo
  echo "#################################################################"
  echo "#######    Generating anchor peer update for mimosMSP   ##########"
  echo "#################################################################"
  configtxgen -profile BEEMSOrgsChannel -outputAnchorPeersUpdate \
  ./channel-artifacts/mimosMSPanchors.tx -channelID $CHANNEL_NAME -asOrg mimosMSP
  if [ "$?" -ne 0 ]; then
    echo "Failed to generate anchor peer update for mimosMSP..."
    exit 1
  fi
  echo
}

