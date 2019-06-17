#!/bin/bash
docker pull hyperledger/fabric-ca:1.4.1
docker pull hyperledger/fabric-peer:1.4.1
docker pull hyperledger/fabric-orderer:1.4.1
docker pull hyperledger/fabric-ccenv:1.4.1
docker pull hyperledger/fabric-tools:1.4.1
docker pull hyperledger/fabric-couchdb:0.4.15

docker tag hyperledger/fabric-ca:1.4.1 hyperledger/fabric-ca
docker tag hyperledger/fabric-peer:1.4.1 hyperledger/fabric-peer
docker tag hyperledger/fabric-orderer:1.4.1 hyperledger/fabric-orderer
docker tag hyperledger/fabric-ccenv:1.4.1 hyperledger/fabric-ccenv
docker tag hyperledger/fabric-tools:1.4.1 hyperledger/fabric-tools
docker tag hyperledger/fabric-couchdb:0.4.15 hyperledger/fabric-couchdb
