#!/bin/sh -eux
yum update && yum upgrade -y
yum install -y curl
sudo yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el6.noarch.rpm
sudo yum clean expire-cache
sudo yum install -y salt-minion salt-ssh
