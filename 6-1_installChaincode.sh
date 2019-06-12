#!/bin/bash

echo "===================== Install chaincode v1.1 in skcc_peer1 ====================="
docker exec skcc_cli peer chaincode install -n sample -v 1.1 -l golang -p github.com/chaincode/chaincode_example02/go

echo -e "\n===================== Install chaincode v1.1 in contractor1_peer1 ====================="
docker exec contractor1_cli peer chaincode install -n sample -v 1.1 -l golang -p github.com/chaincode/chaincode_example02/go
