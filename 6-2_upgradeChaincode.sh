#!/bin/bash
export FABRIC_START_TIMEOUT=3

echo "===================== Upgrade sample chaincode on skccchannel from v1.0 to v1.1 ====================="
docker exec skcc_cli peer chaincode upgrade -o chainz_orderer1:7050 -C skccchannel -n sample -v 1.1 -l golang -c '{"Args":["init","d","100","e","200"]}' -P "AND ('skcc.member','contractor1.member')"

sleep ${FABRIC_START_TIMEOUT}

echo -e "\n===================== Chaincode container launching by query ====================="
docker exec contractor1_cli peer chaincode query -C skccchannel -n sample -c '{"Args":["query","b"]}'
