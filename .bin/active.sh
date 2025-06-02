#!/bin/bash

set -a
source /home/ubuntu/MinecraftGeyserServer/.env
set +a

python3 /home/ubuntu/MinecraftGeyserServer/.bin/active.py >> /home/ubuntu/MinecraftGeyserServer/logs/active.log 2>&1
