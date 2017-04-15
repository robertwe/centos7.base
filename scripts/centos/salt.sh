#!/bin/sh -eux
yum update -y && yum upgrade -y --exclude=kernel*
yum install -y curl
sudo yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el6.noarch.rpm
sudo yum clean expire-cache
sudo yum install -y salt-minion salt-ssh
