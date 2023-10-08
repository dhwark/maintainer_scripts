#!/bin/bash

function docker_install {

    # step 1: 安装必要的一些系统工具
    yum install -y yum-utils device-mapper-persistent-data lvm2
    # Step 2: 添加软件源信息
    yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/fedora/docker-ce.repo
    # Step 3
    sed -i 's+download.docker.com+mirrors.aliyun.com/docker-ce+' /etc/yum.repos.d/docker-ce.repo
    # Step 4: 更新并安装Docker-CE
    yum makecache
    yum -y install docker-ce
    # Step 4: 开启Docker服务
    systemctl start docker
}

function compose_install {
    mv ./docker-compose-linux-x86_64 /usr/local/bin/docker-compose
    chmod u+x /usr/local/bin/docker-compose
    docker-compose --version
}

docker_install
compose_install