#!/bin/bash

set -a
source .env
set +a

sudo docker compose exec minecraft \
  mcrcon -H 127.0.0.1 -P 25575 -p ${RCON_PASSWORD} stop

while pgrep -f "java.*Paper.jar" > /dev/null; do
  sleep 1
done
