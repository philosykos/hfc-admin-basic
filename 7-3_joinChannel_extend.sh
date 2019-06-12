#!/bin/bash

echo "===================== Fetch Genesis Block ====================="
docker exec skcc_cli peer channel fetch 0 skccchannel.block -o chainz_orderer1:7050 -c skccchannel

echo -e "\n===================== Fetch Genesis Block ====================="
docker exec contractor1_cli peer channel fetch 0 skccchannel.block -o chainz_orderer1:7050 -c skccchannel

echo "===================== Join skcc_peer2 to the channel ====================="
docker exec -e CORE_PEER_ADDRESS=skcc_peer2:7051 skcc_cli peer channel join -b skccchannel.block

echo "===================== Join contractor1_peer2 to the channel ====================="
docker exec -e CORE_PEER_ADDRESS=contractor1_peer2:7051 contractor1_cli peer channel join -b skccchannel.block
