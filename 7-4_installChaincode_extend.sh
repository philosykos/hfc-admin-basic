#!/bin/bash

echo "===================== Install chaincode in skcc_peer2 ====================="
docker exec -e CORE_PEER_ADDRESS=skcc_peer2:7051 skcc_cli peer chaincode install -n sample -v 1.1 -l golang -p github.com/chaincode/chaincode_example02/go

echo -e "\n===================== Install chaincode in contractor1_peer2 ====================="
docker exec -e CORE_PEER_ADDRESS=contractor1_peer2:7051 contractor1_cli peer chaincode install -n sample -v 1.1 -l golang -p github.com/chaincode/chaincode_example02/go
