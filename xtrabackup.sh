#!/bin/bash
# 需要提前设置mysql login-path免密登录


date=$(date +%y%m%d)

time=$(date +%y%m%d)-$(date +%H:%M)

day_week=$(date "+%u") # 获取当前星期几

bak_base="/backup/" # 备份存储路径

echo -e "\t"

echo -e "$(date) --- Begin backup Xtrabackup ---\t"

# 增量备份函数
function inc_backup {
    full_bak_path="$bak_base/$date/full" # 完整备份路径
    inc_bak_path="$bak_base/$date/inc-$time" # 增量备份路径

    if [ -e "$full_bak_path" ]; then # 如果完整备份存在，则进行增量备份
        echo -e "$(date) --- Xtrabackup begin inc backup ---\t"
        sleep 3
        mkdir -p "$inc_bak_path"
        xtrabackup --login-path=rootlogin --backup --target-dir="$inc_bak_path" --incremental-basedir="$full_bak_path"
        echo -e "$(date) --- End inc $time backup ---\t"
    else
        full_backup # 如果完整备份不存在，则执行完整备份
    fi
}

# 完整备份函数
function full_backup {
    echo -e "$(date) --- Xtrabackup begin full backup ---\t"
    sleep 3
    full_bak_path="$bak_base/$date/full" # 完整备份路径
    mkdir -p "$full_bak_path"
    xtrabackup --login-path=rootlogin --backup --target-dir="$full_bak_path"
    echo -e "$(date) --- End full backup ---\t"
}


if [ "$day_week" -eq 0 ]; then # 如果是周日（星期日），执行完整备份
    full_backup
else # 否则执行增量备份
    inc_backup
fi
