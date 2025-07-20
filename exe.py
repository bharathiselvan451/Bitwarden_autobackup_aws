import subprocess
import requests

secret = """{"BW_CLIENTID":"user.f12e44f5-3c0d-458d-9d3e-b0c1013353ac","BW_CLIENTSECRET":"b4z8miqAk13mWewimHx8hkZxW8GXjv","BW_PASSWORD":"Yukinoshita@2002"}"""

split_1 = secret.split(",")
list=[]
for x in split_1:
  y = x.split(":")
  list.append(y[1])

my_str = list[2]
my_str = my_str[:-1]
list[2] = my_str

list[0] = list[0].replace('"', '')
list[1] = list[1].replace('"', '')
list[2] = list[2].replace('"', '')

print(list[0],list[1],list[2])

url = "https://raw.githubusercontent.com/bharathiselvan451/Bitwarden_autobackup_aws/refs/heads/main/exe.sh"
r = requests.get(url, allow_redirects=True)
open('damn.sh', 'wb').write(r.content)
open('damn.sh', 'wb').write(r.content)
subprocess.run(["chmod +x damn.sh"],shell=True)
command = "sudo ./damn.sh "+list[2]+" "+list[1]+" "+list[0]
print(command)
subprocess.run([command],shell=True)
