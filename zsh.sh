#!/bin/bash

# 要先复制.zshrc到家目录下
set -e

# 安装zsh
os=$(grep "^ID=" /etc/os-release | cut -d= -f2)
if [ "$os" == "ubuntu" ]; then
    sudo apt install -y zsh git
elif [ "$os" == "centos" ]; then
    sudo yum install -y zsh git
else
    echo "不支持的操作系统"
    exit 1
fi

# 切换为zsh
# 如果其他用户要切换为zsh，还要复制.oh-my-zsh到家目录下
chsh -s $(which zsh)

# 安装oh-my-zsh
echo "no" | sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

sed -i '11s/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/' ~/.zshrc
sed -i '73s/plugins=(git)/plugins=(git zsh-autosuggestions git-extras screen history extract colorize web-search docker)/' ~/.zshrc

/usr/bin/zsh -c "source ~/.zshrc"
