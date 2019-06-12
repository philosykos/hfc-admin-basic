#!/bin/bash
export FABRIC_START_TIMEOUT=2
sleep ${FABRIC_START_TIMEOUT}

echo "===================== Create the channel ====================="
docker exec skcc_cli peer channel create -o chainz_orderer1:7050 -c skccchannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/channel.tx

sleep ${FABRIC_START_TIMEOUT}

echo -e "\n===================== Fetch Genesis Block ====================="
docker exec contractor1_cli peer channel fetch newest skccchannel.block -o chainz_orderer1:7050 -c skccchannel
