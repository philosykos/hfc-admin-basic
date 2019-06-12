#!/bin/bash

docker-compose -f docker-compose-poc.yaml down

echo "===================== Start Fabric Network ====================="
docker-compose -f docker-compose-poc.yaml up -d
