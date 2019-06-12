#!/bin/bash
export PATH=$GOPATH/src/github.com/hyperledger/fabric/.build/bin:${PWD}/../bin:${PWD}:$PATH

# remove previous crypto material
rm -fr ./contractor2-config/crypto-config/*

echo "===================== generate crypto material ====================="
cd contractor2-config
cryptogen generate --config=./crypto-config.yaml
cd ../ && cp -r crypto-config/ordererOrganizations contractor2-config/crypto-config/