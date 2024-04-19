#!/bin/bash
# email:jevinharris@foxmail.com

#yum install -y sshpass

#rm -rf ~/.ssh/id_rsa*
# 小心此句会删除原先的id_rsa密钥
#ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P ""

SSH_PASS=admin888
KEY_PATH=~/.ssh/id_rsa.pub


# 从此文件中读取IP，一行一个地址
ip_list=$(cat ./iplist.txt)

for ip in $ip_list
do
    ssh-keygen -R $ip # 删除过期指纹
    ping -c2 $ip >/dev/null 2>&1
    if [ $? -eq 0 ];then
        echo -e "\033[33m${ip} is UP\033[0m"
        echo "======= Distribute Key To The Host $ip =========="	
	    sshpass -p $SSH_PASS ssh-copy-id -i $KEY_PATH "-o StrictHostKeyChecking=no" $ip &>/dev/null
        echo "$ip 密钥分发成功"
	    echo  -e "##########################END##########################\n"
    else
        echo "======= Warning Host $ip =========="
        echo -e "\033[33m${ip} IS DOWN\033[0m"
        echo "$ip 无法ping通,密钥分发失败"
        echo  -e "##########################FAIL##########################\n"
    fi

done
