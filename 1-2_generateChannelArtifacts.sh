#!/bin/bash
export PATH=$GOPATH/src/github.com/hyperledger/fabric/.build/bin:${PWD}/../bin:${PWD}:$PATH
CHANNEL_NAME=skccchannel

# remove config transactions
rm -fr config/*
mkdir config

echo "===================== generate genesis block for orderer ====================="
configtxgen -profile TwoOrgsSoloGenesis -outputBlock ./config/genesis.block

echo "===================== generate channel configuration transaction ====================="
configtxgen -profile TwoOrgsSoloChannel -outputCreateChannelTx ./config/channel.tx -channelID $CHANNEL_NAME

echo "===================== generate anchor peer transaction ====================="
configtxgen -profile TwoOrgsSoloChannel -outputAnchorPeersUpdate ./config/skccAnchors.tx -channelID $CHANNEL_NAME -asOrg skcc

echo "===================== generate anchor peer transaction ====================="
configtxgen -profile TwoOrgsSoloChannel -outputAnchorPeersUpdate ./config/contractor1Anchors.tx -channelID $CHANNEL_NAME -asOrg contractor1
