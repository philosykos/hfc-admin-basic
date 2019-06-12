#!/bin/bash

echo "===================== Install chaincode v2.0 in skcc_peer1 ====================="
docker exec skcc_cli peer chaincode install -n sample -v 2.0 -l golang -p github.com/chaincode/chaincode_example02/go

echo "===================== Install chaincode v2.0 in skcc_peer2 ====================="
docker exec -e CORE_PEER_ADDRESS=skcc_peer2:7051 skcc_cli peer chaincode install -n sample -v 2.0 -l golang -p github.com/chaincode/chaincode_example02/go

echo -e "\n===================== Install chaincode v2.0 in contractor1_peer1 ====================="
docker exec contractor1_cli peer chaincode install -n sample -v 2.0 -l golang -p github.com/chaincode/chaincode_example02/go

echo -e "\n===================== Install chaincode v2.0 in contractor1_peer2 ====================="
docker exec -e CORE_PEER_ADDRESS=contractor1_peer2:7051 contractor1_cli peer chaincode install -n sample -v 2.0 -l golang -p github.com/chaincode/chaincode_example02/go

echo -e "\n===================== Install chaincode v2.0 in contractor2_peer1 ====================="
docker exec contractor2_cli peer chaincode install -n sample -v 2.0 -l golang -p github.com/chaincode/chaincode_example02/go

echo -e "\n===================== Install chaincode v2.0 in contractor2_peer2 ====================="
docker exec -e CORE_PEER_ADDRESS=contractor2_peer2:7051 contractor2_cli peer chaincode install -n sample -v 2.0 -l golang -p github.com/chaincode/chaincode_example02/go