import json
import boto3
import os

def lambda_handler(event, context):
    # TODO implement
    
        
    
        ec2 = boto3.resource('ec2', region_name="us-east-1")
        iam_client = boto3.client('iam')


        ec2.create_instances(
           ImageId='ami-020cba7c55df1f615',
           InstanceType='t2.micro',
           UserData='#!/bin/bash \n curl --output exe.py "https://raw.githubusercontent.com/bharathiselvan451/Bitwarden_autobackup_aws/refs/heads/main/exe.py" \n python3 exe.py',
           IamInstanceProfile={
            'Arn' : 'arn:aws:iam::825765393793:instance-profile/EC2_secret'
           },
           MaxCount=1,
           MinCount=1,
           TagSpecifications=[{
            'ResourceType':'instance',
            'Tags': [
                {
                    'Key': 'name',
                    'Value': 'bitwarden'
                },
            ]
            },
    ]
        )
   
    
