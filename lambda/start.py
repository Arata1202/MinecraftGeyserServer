import boto3
import time
import json
import os
import urllib.request

def lambda_handler(event, context):
    instance_id = os.environ['INSTANCE_ID']
    region = os.environ.get('AWS_REGION', 'ap-northeast-1')
    webhook_url = os.environ['WEBHOOK_URL']

    ec2 = boto3.client('ec2', region_name=region)
    ec2.start_instances(InstanceIds=[instance_id])

    while True:
        instance = ec2.describe_instances(InstanceIds=[instance_id])
        state = instance['Reservations'][0]['Instances'][0]['State']['Name']
        if state == 'running':
            break
        time.sleep(5)

    public_ip = instance['Reservations'][0]['Instances'][0].get('PublicIpAddress', 'IP未取得')

    data = json.dumps({
        'content': f'サーバーの起動が完了しました\nパブリック IPv4 アドレス：{public_ip}'
    }).encode('utf-8')

    req = urllib.request.Request(
        webhook_url,
        data=data,
        headers={
            'Content-Type': 'application/json',
            'User-Agent': 'Mozilla/5.0 (compatible; LambdaBot/1.0)'
        }
    )

    urllib.request.urlopen(req)

    return public_ip