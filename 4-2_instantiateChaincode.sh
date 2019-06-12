#!/bin/bash
export FABRIC_START_TIMEOUT=3

echo "===================== Instantiate sample chaincode v1.0 to skccchannel ====================="
docker exec skcc_cli peer chaincode instantiate -o chainz_orderer1:7050 -C skccchannel -n sample -v 1.0 -l golang -c '{"Args":["init","a","100","b","200"]}' -P "AND ('skcc.member','contractor1.member')"

sleep ${FABRIC_START_TIMEOUT}

echo -e "\n===================== Chaincode container launching by query ====================="
docker exec contractor1_cli peer chaincode query -C skccchannel -n sample -c '{"Args":["query","b"]}'
