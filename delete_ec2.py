import json
import boto3
region = 'us-east-1'

ec2 = boto3.client('ec2', region_name=region)

def get_instance_ids():

    all_instances = ec2.describe_instances()
    
    instance_ids = []
    
    # find instance-id based on instance name
    # many for loops but should work
    
    for reservation in all_instances['Reservations']:
        for instance in reservation['Instances']:
            if 'Tags' in instance:
                for tag in instance['Tags']:
                    print(tag['Key'] + " : " + tag['Value'])
                    if tag['Key'] == 'name' \
                        and tag['Value'] == "bitwarden":
                        instance_ids.append(instance['InstanceId'])
                        print(instance['InstanceId'],"here")
    return instance_ids


def lambda_handler(event, context):
    # TODO implement
    

    instance_ids = get_instance_ids()
    print(instance_ids)
    ec2.terminate_instances(InstanceIds=instance_ids)

    
