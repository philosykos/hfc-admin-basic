#!/bin/bash

echo "===================== Anchor peer update for skcc org ====================="
docker exec skcc_cli peer channel update -o chainz_orderer1:7050 -c skccchannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/skccAnchors.tx

echo -e "\n===================== Anchor peer update for contractor1 org ====================="
docker exec contractor1_cli peer channel update -o chainz_orderer1:7050 -c skccchannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/contractor1Anchors.tx
