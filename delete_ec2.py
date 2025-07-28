import json
import boto3
import smtplib
from email.mime.text import MIMEText
from botocore.exceptions import ClientError
import ast




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

def send_email():
    secret_name = "Bitwarden"
    region_name = "us-east-1"

    # Create a Secrets Manager client
    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name
    )

    get_secret_value_response = client.get_secret_value(
        SecretId=secret_name
        )
    

    secret = get_secret_value_response['SecretString']

    list =  ast.literal_eval(secret)
    server = smtplib.SMTP('smtp.gmail.com',587)
    server.starttls()
    server.login(list['email'],list['password'])
    server.sendmail(list['email'],'bharathiselvan451@gmail.com','Bitwarden monthly back up is done')
    server.quit()


def lambda_handler(event, context):
    # TODO implement
    instance_ids = get_instance_ids()
    print(instance_ids)
    ec2.terminate_instances(InstanceIds=instance_ids)
    send_email()

    
