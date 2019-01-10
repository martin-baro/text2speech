import boto3
import os
from boto3.dynamodb.conditions import Key, Attr

def lambda_handler(event, context):
    
    searchText = event["searchText"]
    
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(os.environ['DB_TABLE_NAME'])
    
    if searchText=="*":
        items = table.scan()
    else:
        items = table.scan(
            FilterExpression=Attr('text').contains(searchText)
        )
    
    return items["Items"]