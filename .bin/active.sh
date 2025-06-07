#!/bin/bash

set -a
source /home/ubuntu/MinecraftGeyserServer/.env
set +a

cd /home/ubuntu/MinecraftGeyserServer
docker compose run --rm batch
