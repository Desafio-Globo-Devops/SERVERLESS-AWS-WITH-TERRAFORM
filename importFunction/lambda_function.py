import boto3
import json
import random

s3_client = boto3.client('s3')
dynamodb = boto3.client('dynamodb')


def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    json_file_name = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding-'utf-8')
    json_object = s3_client.get_object(Bucket=bucket, Key=json_file_name)
    jsonFileReader = json_object['Body'].read()
    jsonDict = json.loads(jsonFileReader)
    table = dynamodb.Table('Event_Capture')
    Records = jsonDict['Records']
    ID = random.getrandbits(128)
    for log in Records:
        if log:
            log['ID'] = str(ID)
        table.put_item(Item=log)
    return 'Create with Success'

