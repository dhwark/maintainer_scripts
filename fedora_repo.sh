#!/bin/bash
mv /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora.repo.backup
mv /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/fedora-updates.repo.backup

wget -O /etc/yum.repos.d/fedora.repo http://mirrors.aliyun.com/repo/fedora.repo
wget -O /etc/yum.repos.d/fedora-updates.repo http://mirrors.aliyun.com/repo/fedora-updates.repo

sudo yum makecache