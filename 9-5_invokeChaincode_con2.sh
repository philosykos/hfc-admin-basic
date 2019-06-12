#!/bin/bash

echo "===================== invoke transaction ====================="
docker exec skcc_cli peer chaincode invoke -o chainz_orderer1:7050 -C skccchannel -n sample --peerAddresses skcc_peer1:7051 --peerAddresses contractor1_peer1:7051 --peerAddresses contractor2_peer1:7051 -c '{"Args":["invoke","g","f","e","100"]}'
