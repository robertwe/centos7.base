#!/bin/sh -eux

mkdir -p /etc;
yum update && yum upgrade -y
