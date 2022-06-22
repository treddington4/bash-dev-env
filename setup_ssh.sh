#! /bin/bash

mkdir -p ~/.ssh && chmod 700 ~/.ssh
touch ~/.ssh/config
# setup ssh
ssh-keygen -f ~/.ssh/id_rsa -t rsa -b 4096 -y

github_exist=$(cat ~/.ssh/config | grep github.com)
if [ -z $github_exist ]; then
    printf "Host %s\n\tHostName %s\n\tUser %s\n\tPreferredAuthentications %s\n\tIdentityFile %s\n\n" github.com github.com git publickey ~/.ssh/id_rsa >> ~/.ssh/config
fi
