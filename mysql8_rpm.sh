#!/bin/bash

mkdir mysql_install
cd mysql_install
wget https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-8.0.32-1.el9.x86_64.rpm-bundle.tar

tar -xvf mysql-8.0.32-1.el9.x86_64.rpm-bundle.tar

yum remove mariadb-connector-c-config
rpm -ivh *.rpm

systemctl enable mysqld
systemctl start mysqld

cat /var/log/mysqld.log |grep password

# 使用上面显示的临时密码登录,mysql -u root -p
# ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'sEDWqJvBw2HJba@';
# 填入你的密码