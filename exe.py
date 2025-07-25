import subprocess
import requests
import boto3
from botocore.exceptions import ClientError
import ast



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


#split_1 = secret.split(",")
#for x in split_1:
  #y = x.split(":")
  #list.append(y[1])

#my_str = list[2]
#my_str = my_str[:-1]
#list[2] = my_str

#list[0] = list[0].replace('"', '')
#list[1] = list[1].replace('"', '')
#list[2] = list[2].replace('"', '')

#print(list[0],list[1],list[2])

url = "https://raw.githubusercontent.com/bharathiselvan451/Bitwarden_autobackup_aws/refs/heads/main/exe.sh"
r = requests.get(url, allow_redirects=True)
open('damn.sh', 'wb').write(r.content)
#open('damn.sh', 'wb').write(r.content)
subprocess.run(["chmod +x damn.sh"],shell=True)
#command = "./damn.sh "+list[2]+" "+list[1]+" "+list[0]
command = "./damn.sh "+list['BW_PASSWORD']+" "+list['BW_CLIENTSECRET']+" "+list['BW_CLIENTID']
print(command)
subprocess.run([command],shell=True)
