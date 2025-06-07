#!/bin/bash

set -a
source /server/.env
set +a

cd /server && docker compose run --rm batch
