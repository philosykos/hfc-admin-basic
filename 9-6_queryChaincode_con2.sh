#!/bin/bash

echo "===================== Query data of contractor2_peer1 ====================="
docker exec contractor2_cli peer chaincode query -C skccchannel -n sample -c '{"Args":["query","g"]}'

echo -e "\n===================== Query data of contractor2_peer2 ====================="
docker exec -e CORE_PEER_ADDRESS=contractor2_peer2:7051 contractor2_cli peer chaincode query -C skccchannel -n sample -c '{"Args":["query","f"]}'

echo -e "\n===================== Query data of contractor2_peer1 ====================="
docker exec contractor2_cli peer chaincode query -C skccchannel -n sample -c '{"Args":["query","e"]}'