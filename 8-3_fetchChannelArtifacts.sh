#!/bin/bash

echo "===================== Installing jq ====================="
docker exec skcc_cli apt-get -y update && apt-get -y install jq

echo -e "\n===================== Fetching the most recent configuration block for the channel ====================="
docker exec skcc_cli peer channel fetch config config_block.pb -o chainz_orderer1:7050 -c skccchannel

echo -e "\n===================== Decoding config block to JSON and isolating config to original_config.json ====================="
set -x
docker exec skcc_cli configtxlator proto_decode --input config_block.pb --type common.Block | jq .data.data[0].payload.data.config > ./config/original_config.json
set +x

echo -e "\n===================== Modify the configuration to append contractor2 ====================="
set -x
docker exec skcc_cli jq -s '.[0] * {"channel_group":{"groups":{"Application":{"groups": {"contractor2":.[1]}}}}}' ./channel-artifacts/original_config.json ./channel-artifacts/contractor2.json > ./config/modified_config.json
set +x

echo -e "\n===================== Configuration Update ====================="
set -x
docker exec skcc_cli configtxlator proto_encode --input ./channel-artifacts/original_config.json --type common.Config > ./config/original_config.pb
docker exec skcc_cli configtxlator proto_encode --input ./channel-artifacts/modified_config.json --type common.Config > ./config/modified_config.pb
docker exec skcc_cli configtxlator compute_update --channel_id skccchannel --original ./channel-artifacts/original_config.pb --updated ./channel-artifacts/modified_config.pb > ./config/config_update.pb
docker exec skcc_cli configtxlator proto_decode --input ./channel-artifacts/config_update.pb --type common.ConfigUpdate > ./config/config_update.json
echo '{"payload":{"header":{"channel_header":{"channel_id":"skccchannel", "type":2}},"data":{"config_update":'$(cat ./config/config_update.json)'}}}' > ./config/envelope.json
docker exec skcc_cli cat ./channel-artifacts/envelope.json | jq . > ./config/config_update_in_envelope.json
docker exec skcc_cli configtxlator proto_encode --input ./channel-artifacts/config_update_in_envelope.json --type common.Envelope > ./config/contractor2_update_in_envelope.pb
set +x