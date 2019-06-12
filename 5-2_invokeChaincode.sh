#!/bin/bash

echo "===================== invoke transaction(send 10 a to b) ====================="
docker exec skcc_cli peer chaincode invoke -o chainz_orderer1:7050 -C skccchannel -n sample --peerAddresses skcc_peer1:7051 --peerAddresses contractor1_peer1:7051 -c '{"Args":["invoke","a","b","c","10"]}'
