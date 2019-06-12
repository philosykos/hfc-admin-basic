#!/bin/bash

echo "===================== Fetch Genesis Block ====================="
docker exec contractor2_cli peer channel fetch 0 skccchannel.block -o chainz_orderer1:7050 -c skccchannel

echo "===================== Join contractor2_peer1 to the channel ====================="
docker exec contractor2_cli peer channel join -b skccchannel.block

echo -e "\n===================== Join contractor2_peer2 to the channel ====================="
docker exec -e CORE_PEER_ADDRESS=contractor2_peer2:7051 contractor2_cli peer channel join -b skccchannel.block