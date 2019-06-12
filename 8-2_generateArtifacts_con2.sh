#!/bin/bash
export PATH=$GOPATH/src/github.com/hyperledger/fabric/.build/bin:${PWD}/../bin:${PWD}:$PATH

cd contractor2-config
configtxgen -printOrg contractor2 > ../config/contractor2.json
