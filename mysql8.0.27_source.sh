#!/bin/bash

# 安装依赖
yum install -y gcc gcc-c++ ncurses-devel cmake make perl wget git openssl-devel

cd /root/
# 下载 MySQL 8 源码包
wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.27.tar.gz

# 解压源码包
tar -zxf mysql-8.0.27.tar.gz

mkdir /usr/local/mysql-build
cd /usr/local/mysql-build

# 配置 MySQL 8 编译参数
cmake /root/mysql-8.0.27 \
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DDOWNLOAD_BOOST=1 \
-DWITH_BOOST=/usr/local/src/boost \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_general_ci \
-DMYSQL_DATADIR=/usr/local/mysql/data \
-DENABLED_LOCAL_INFILE=ON \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_EXAMPLE_STORAGE_ENGINE=1 \
-DWITH_FEDERATED_STORAGE_ENGINE=1 \
-DWITH_MEMORY_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITH_PERFSCHEMA_STORAGE_ENGINE=1 \
-DWITH_ROCKSDB_STORAGE_ENGINE=1 \
-DWITH_SPIDER_STORAGE_ENGINE=1 \
-DOPENSSL_ROOT_DIR=/usr/lib64 \
-DWITH_SYSTEMD=1 \
-DWITH_LIBEVENT=system

# 编译并安装 MySQL 8
make && make install

# 配置 MySQL 环境变量
echo 'export PATH=$PATH:/usr/local/mysql/bin' >> /etc/profile
source /etc/profile

# 创建 mysql 用户
useradd -s /sbin/nologin mysql

# 修改 MySQL 相关目录的所有权和权限
chown -R mysql:mysql /usr/local/mysql /usr/local/mysql/data
chmod -R 750 /usr/local/mysql /usr/local/mysql/data

# 初始化 MySQL 数据库
cd /usr/local/mysql
./bin/mysqld --initialize-insecure --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data

# 启动 MySQL 服务
./bin/mysqld_safe --user=mysql &