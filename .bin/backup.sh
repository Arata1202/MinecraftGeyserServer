#!/bin/bash

set -a
source .env
set +a

BACKUP_NAME="minecraft_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
TMP_PATH="/tmp/$BACKUP_NAME"

tar -czf "$TMP_PATH" \
    world \
    world_nether \
    world_the_end \
    server.properties

aws s3 cp "$TMP_PATH" "s3://$BUCKET_NAME/backups/$BACKUP_NAME"

rm "$TMP_PATH"
