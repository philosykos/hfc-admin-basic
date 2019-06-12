#!/bin/bash
export FABRIC_START_TIMEOUT=3

echo "===================== Upgrade sample chaincode of skccchannel ====================="
docker exec skcc_cli peer chaincode upgrade -o chainz_orderer1:7050 -C skccchannel -n sample -v 2.0 -l golang -c '{"Args":["init","f","1000","g","2000"]}' -P "AND ('skcc.member','contractor1.member','contractor2.member')"

sleep ${FABRIC_START_TIMEOUT}

echo -e "\n===================== Chaincode container launching by query ====================="
docker exec contractor2_cli peer chaincode query -C skccchannel -n sample -c '{"Args":["query","f"]}'

echo -e "\n===================== Chaincode container launching by query ====================="
docker exec -e CORE_PEER_ADDRESS=contractor2_peer2:7051 contractor2_cli peer chaincode query -C skccchannel -n sample -c '{"Args":["query","g"]}'