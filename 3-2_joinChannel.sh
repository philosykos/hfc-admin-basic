#!/bin/bash

echo "===================== Join skcc_peer1 to the channel ====================="
docker exec skcc_cli peer channel join -b skccchannel.block

echo -e "\n===================== Join contractor1_peer1 to the channel ====================="
docker exec contractor1_cli peer channel join -b skccchannel.block
