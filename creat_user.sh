#!/bin/bash

USER_LIST=$@
USER_FILE=./user.txt
for USER in $USER_LIST;do
    if ! id $USER  &>/dev/null; then
        PASS=$(echo $RANDOM |md5sum |cut -c 1-8)
        useradd $USER
        passwd $PASS $USER
        echo "$USER $PASS" >> $USER_FILE
        echo "$USER 创建成功"
    else
        echo "$USER 已存在"
    fi
done
