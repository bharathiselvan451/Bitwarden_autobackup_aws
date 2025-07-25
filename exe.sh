#!/bin/bash
export BW_PASSWORD=$1
export BW_CLIENTSECRET=$2
export BW_CLIENTID=$3
source ~/.bashrc
yes '' | apt-add-repository universe
apt-get -y install expect
apt update && apt install -y curl unzip libsecret-1-0 jq
export VER=$(curl -H "Accept: application/vnd.github+json" https://api.github.com/repos/bitwarden/clients/releases | jq  -r 'sort_by(.published_at) | reverse | .[].name | select( index("CLI") )' | sed 's:.*CLI v::' | head -n 1) && \
curl -LO "https://github.com/bitwarden/clients/releases/download/cli-v{$VER}/bw-linux-{$VER}.zip" \
&& unzip *.zip && chmod +x ./bw
./bw login --apikey
expect -c "
spawn ./bw export --format json
expect -nocase \"password:\" {send \"$1\r\";}
expect of
"
sudo snap install aws-cli --classic
json_files=(*.json)
# Extract only the filenames (without path)
filenames=( "${json_files[@]##*/}" )
aws s3 cp $json_files s3://bitwarden-backup-monthly/
