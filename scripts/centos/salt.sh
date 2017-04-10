#!/bin/sh -eux
yum update && yum upgrade -y
yum install -y curl
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sh install_salt.sh -P
