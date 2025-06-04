#!/bin/bash

set -a
source .env
set +a

cd /home/ubuntu/MinecraftGeyserServer
docker compose run --rm batch
