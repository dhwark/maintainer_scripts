#!/bin/bash

function docker_install {
    yum -y install yum-utils
    yum-config-manager \
        --add-repo \
        http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

    yum install -y docker

    systemctl start docker

    systemctl enable docker
}

docker_install