#!/bin/bash

set -e

# 安装zsh
sudo yum install -y zsh git

# 切换为zsh
chsh -s $(which zsh)

# 安装oh-my-zsh
echo "no" | sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

sed -i '11s/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/' ~/.zshrc
sed -i '73s/plugins=(git)/plugins=(git zsh-autosuggestions git-extras screen history extract colorize web-search docker)/' ~/.zshrc

/usr/bin/zsh -c "source ~/.zshrc"
