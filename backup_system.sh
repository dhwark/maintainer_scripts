#!/bin/bash

set -e
time=$(date +%y%m%d)-$(date +%H-%M)

cp -pr /var/lib/docker ./backup_system
cp -pr /etc/docker ./backup_system/etc
cp -pr /home/jevin ./backup_system
cp -pr /data ./backup_system
cp -pr /showdoc_data ./backup_system
cp -pr /usr/local/nginx ./backup_system
cp -pr /opt/1panel ./backup_system
cp -pr /usr/local/frps ./backup_system

tar -zcf backup_system_${time}.tar.gz ./backup_system