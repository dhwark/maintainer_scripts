#!/bin/bash

function containerd_install {
    # step 1: 安装必要的一些系统工具
    yum install -y yum-utils device-mapper-persistent-data lvm2
    # Step 2: 添加软件源信息
    yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    # Step 3
    sed -i 's+download.docker.com+mirrors.aliyun.com/docker-ce+' /etc/yum.repos.d/docker-ce.repo
    # Step 4: 更新并安装Docker-CE
    yum makecache
    yum -y install containerd
    # Step 4: 开启containerd服务
    systemctl enable containerd
    systemctl start containerd
}

sed -i '/disabled_plugins = \["cri"\]/s/^/# /' /etc/containerd/config.toml

containerd_install