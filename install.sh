#!/bin/bash

set -eu

#パスワードの取得
echo "インストール用シェルスクリプト"
echo -n "password:"
read -s password


#apt
cat ./apt_repositories.txt | while read rep
do
    echo "$password" | sudo -S add-apt-repository -y "$rep"
done
echo "$password" | sudo -S apt -y update
echo "$password" | sudo -S apt -y install $(cat ./apt_requirements.txt) 

#pip
echo "$password" | sudo pip3 install --upgrade pip
echo "$password" | sudo pip3 install pip-tools
pip-compile pip_requirements.in
echo "$password" | sudo pip3 install -r pip_requirements.txt

#日本語がよくなる（っぽい）
wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | sudo apt-key add -
wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | sudo apt-key add -
sudo wget https://www.ubuntulinux.jp/sources.list.d/xenial.list -O /etc/apt/sources.list.d/ubuntu-ja.list

echo "おしまい"
