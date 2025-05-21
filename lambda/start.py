import boto3
import time
import json
import os
import urllib.request
from botocore.exceptions import ClientError

def lambda_handler(event, context):
    instance_id = os.environ['INSTANCE_ID']
    region = os.environ.get('AWS_REGION', 'ap-northeast-1')
    webhook_url = os.environ['WEBHOOK_URL']

    ssm = boto3.client('ssm', region_name=region)
    ec2 = boto3.client('ec2', region_name=region)

    ec2.start_instances(InstanceIds=[instance_id])

    while True:
        instance = ec2.describe_instances(InstanceIds=[instance_id])
        state = instance['Reservations'][0]['Instances'][0]['State']['Name']
        if state == 'running':
            break
        time.sleep(5)

    while True:
        statuses = ec2.describe_instance_status(InstanceIds=[instance_id])
        if statuses['InstanceStatuses']:
            inst_status = statuses['InstanceStatuses'][0]['InstanceStatus']['Status']
            sys_status = statuses['InstanceStatuses'][0]['SystemStatus']['Status']
            if inst_status == 'ok' and sys_status == 'ok':
                break
        time.sleep(5)

    response = ssm.send_command(
        InstanceIds=[instance_id],
        DocumentName="AWS-RunShellScript",
        Parameters={'commands': ["cd /home/ubuntu/MinecraftGeyserServer && sudo make up"]},
    )

    command_id = response['Command']['CommandId']

    while True:
        try:
            result = ssm.get_command_invocation(
                CommandId=command_id,
                InstanceId=instance_id
            )
            if result['Status'] in ['Success', 'Cancelled', 'TimedOut', 'Failed']:
                break
        except ClientError as e:
            if "InvocationDoesNotExist" in str(e):
                time.sleep(1)
                continue
            else:
                raise e
        time.sleep(1)

    public_ip = instance['Reservations'][0]['Instances'][0].get('PublicIpAddress', 'IP未取得')

    if result['Status'] != 'Success':
        message = f"make up に失敗しました⚠️: {result['Status']}"
    else:
        message = f'サーバーの起動が完了しました🟢'

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

    return {"status": result['Status'], "ip": public_ip}