#!/bin/bash

echo "===================== Query data of skcc_peer1 ====================="
docker exec skcc_cli peer chaincode query -C skccchannel -n sample -c '{"Args":["query","a"]}'

echo -e "\n===================== Query data of contractor1_peer1 ====================="
docker exec contractor1_cli peer chaincode query -C skccchannel -n sample -c '{"Args":["query","b"]}'

echo -e "\n===================== Query data of skcc_peer1 ====================="
docker exec skcc_cli peer chaincode query -C skccchannel -n sample -c '{"Args":["query","c"]}'