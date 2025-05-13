import boto3
import time
import json
import os
import urllib.request

def lambda_handler(event, context):
    instance_id = os.environ['INSTANCE_ID']
    region = os.environ.get('AWS_REGION', 'ap-northeast-1')
    webhook_url = os.environ['WEBHOOK_URL']

    ssm = boto3.client('ssm', region_name=region)
    ec2 = boto3.client('ec2', region_name=region)

    response = ssm.send_command(
        InstanceIds=[instance_id],
        DocumentName="AWS-RunShellScript",
        Parameters={'commands': ["cd /home/ubuntu/MinecraftGeyserServer && make down"]},
    )

    command_id = response['Command']['CommandId']

    for _ in range(30):
        result = ssm.get_command_invocation(
            CommandId=command_id,
            InstanceId=instance_id
        )
        if result['Status'] in ['Success', 'Cancelled', 'TimedOut', 'Failed']:
            break
        time.sleep(1)

    if result['Status'] != 'Success':
        message = f"make down に失敗しました ❌\nStatus: {result['Status']}\n{result.get('StandardErrorContent', '')}"
    else:
        ec2.stop_instances(InstanceIds=[instance_id])
        message = 'サーバーの停止が完了しました🛑'

    data = json.dumps({'content': message}).encode('utf-8')

    req = urllib.request.Request(
        webhook_url,
        data=data,
        headers={
            'Content-Type': 'application/json',
            'User-Agent': 'Mozilla/5.0 (compatible; LambdaBot/1.0)'
        }
    )

    urllib.request.urlopen(req)

    return {"status": "stopped"}