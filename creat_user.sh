#!/bin/bash


IP_LIST=$1
# 此处可以使用$@传递多个IP，但是就无法传入CMD了，可以在文件中定义IP列表
CMD=$2
for IP in ${IP_LIST};do
    ssh -o StrictHostKeyChecking=no root@${IP} ${CMD}
    if [ $? -eq 0 ];then
        echo "ssh cmd ${IP} success"
    else
        echo "ssh cmd ${IP} failed"
    fi  
done