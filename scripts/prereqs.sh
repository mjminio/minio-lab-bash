#!/bin/bash

set -e
G="\e[32m"
E="\e[0m"

if ! grep -q 'Ubuntu' /etc/issue
  then
    echo -----------------------------------------------
    echo "Not Ubuntu? Could not find Codename Ubuntu in lsb_release -a. Please switch to Ubuntu."
    echo -----------------------------------------------
    exit 1
fi

## Update OS
sudo apt update
sudo apt upgrade -y

## Install Prereqs
sudo apt-get install -y acl apache2-utils apt-transport-https bash-completion build-essential ca-certificates certbot curl fonts-firacode \
git gnupg haveged htop jq libnss3-tools libfontconfig1 libgtk-3-0 libxi6 libxrender1 libxtst6 locales lsb-release net-tools openssl python3-pip \
software-properties-common telnet tree unzip zsh zsh-autosuggestions zip

## Create user
echo "Creating Minio user..."
if id $MINIO_USER &>/dev/null ; then
    echo "$MINIO_USER exists. No need to add user."
else
    sudo adduser --shell /etc/zsh --disabled-password --gecos "" $MINIO_USER
    sudo usermod -aG sudo $MINIO_USER
    echo '$ a ${USER} ALL=(ALL:ALL) NOPASSWD: ALL' | EDITOR="sed -f- -i" visudo
fi

## Docker Things ##
## Installing Docker Engine
echo "Installing Docker Engine..."
FILE=/usr/bin/docker
if [ -f "$FILE" ]; then
    echo "$FILE exists. No need to install Docker again."
else
    echo "$FILE does not exist. Installing Docker."
    curl -fsSL https://get.docker.com -o /tmp/get-docker.sh > /dev/null 2>&1
    sudo sh /tmp/get-docker.sh > /dev/null 2>&1
    sudo usermod -aG docker $MINIO_USER
fi

## Installing Docker Compose
echo "Installing Docker Compose..."
curl -SL https://github.com/docker/compose/releases/download/v2.10.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose > /dev/null 2>&1
sudo chmod +x /usr/local/bin/docker-compose > /dev/null 2>&1

## Install mkcert
FILE=/usr/local/bin/mkcert
if [ -f "$FILE" ]; then
    echo "$FILE exists. No need to install mkcert again."
else
    curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
    chmod +x mkcert-v*-linux-amd64
    sudo cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert
fi