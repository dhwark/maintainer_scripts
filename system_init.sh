#!/bin/bash


yum_change() {
    yum -y install wget
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
    mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup
    mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/epel-testing.repo.backup
    wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
    # or curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
    wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
    yum clean all
    yum makecache
}

zsh_install() {
    # 安装zsh
    sudo yum install -y zsh git

    # 切换为zsh
    chsh -s $(which zsh)

    # 安装oh-my-zsh
    echo "no" |sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

    sed -i '11s/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/' ~/.zshrc
    sed -i '73s/plugins=(git)/plugins=(git zsh-autosuggestions git-extras screen history extract colorize web-search docker)/' ~/.zshrc

    /usr/bin/zsh -c "source ~/.zshrc"
}

# 调用yum源修改函数
yum_change

# 设置时区
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 时间同步
yum install -y ntp
ntpdate ntp1.aliyun.com
cat >> /etc/crontab << 'EOF'
0 0 * * * root ntpdate ntp1.aliyun.com
EOF

# 禁用selinux
sed -i 's/SELINUX=.*/#/g' /etc/selinux/config
setenforce 0

# # 禁止root远程登陆
# sudo sed -i 's/#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
# # 重新启动SSH服务器
# sudo service ssh restart

# 高并发情况下内核参数优化
ulimit -SHn 65535
echo "net.core.somaxconn=65535" >> /etc/sysctl.conf
echo "net.core.netdev_max_backlog=10000" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog=65535" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_tw_buckets=200000" >> /etc/sysctl.conf
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
sysctl -p

# 写入vim的默认配置
cat > /root/.vimrc << 'EOF'
set nu
set ai
set ts=4
set et
autocmd FileType yaml setlocal sw=2 ts=2 et ai
EOF

# 减少swap使用
echo "0" > /proc/sys/vm/swappiness


# 安装zsh(可选)
zsh_install