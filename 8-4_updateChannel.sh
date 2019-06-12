#!/bin/bash

echo "===================== Signing the config update with skcc org admin ====================="
docker exec skcc_cli peer channel signconfigtx -f ./channel-artifacts/contractor2_update_in_envelope.pb

echo "===================== Signing the config update with contractor1 org admin ====================="
docker exec contractor1_cli peer channel signconfigtx -f ./channel-artifacts/contractor2_update_in_envelope.pb

echo -e "\n===================== Update channel config ====================="
docker exec skcc_cli peer channel update -f ./channel-artifacts/contractor2_update_in_envelope.pb -c skccchannel -o chainz_orderer1:7050
