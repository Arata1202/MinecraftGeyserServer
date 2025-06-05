#!/bin/bash

set -a
source .env
set +a

ZONEID=${1:-$ROUTE53_ZONEID}
FQDN=${2:-$ROUTE53_FQDN}

TOKEN=`curl -X PUT -H "X-aws-ec2-metadata-token-ttl-seconds:300" http://169.254.169.254/latest/api/token`
PUBIP=`curl -X GET -H "X-aws-ec2-metadata-token:${TOKEN}" http://169.254.169.254/latest/meta-data/public-ipv4`

echo $PUBIP

JSON="{\"Changes\": [
    {
      \"Action\": \"UPSERT\",
      \"ResourceRecordSet\": {
        \"Name\": \"${FQDN}\",
        \"Type\": \"A\",
        \"TTL\": 60,
        \"ResourceRecords\": [
          {
            \"Value\": \"$PUBIP\"
          }
        ]
      }
    }
  ]
}"

aws route53 change-resource-record-sets --hosted-zone-id $ZONEID --change-batch  "$JSON"
