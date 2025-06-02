#!/bin/bash

set -a
source .env
set +a

BACKUP_NAME="minecraft_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
TMP_PATH="/tmp/$BACKUP_NAME"

tar --exclude='.git' -czf "$TMP_PATH" .

aws s3 cp "$TMP_PATH" "s3://$BUCKET_NAME/backups/$BACKUP_NAME"

rm "$TMP_PATH"
