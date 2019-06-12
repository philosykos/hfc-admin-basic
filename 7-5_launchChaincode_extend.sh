#!/bin/bash

echo "===================== Chaincode container launching by query ====================="
docker exec -e CORE_PEER_ADDRESS=skcc_peer2:7051 skcc_cli peer chaincode query -C skccchannel -n sample -c '{"Args":["query","a"]}'

echo -e "\n===================== Chaincode container launching by query ====================="
docker exec -e CORE_PEER_ADDRESS=contractor1_peer2:7051 contractor1_cli peer chaincode query -C skccchannel -n sample -c '{"Args":["query","b"]}'
