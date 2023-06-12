#!/bin/bash

# Run apt-get update & upgrade
sudo apt-get -y update
sudo apt-get -y upgrade

# Install and move Go to $PATH environment
wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
sudo tar -C /usr/local/ -xzf go1.13.5.linux-amd64.tar.gz
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
echo 'export GOROOT=/usr/local/go' >> ~/.bash_profile
echo 'export GOPATH=$HOME/go'	>> ~/.bash_profile			
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH\n' >> ~/.bash_profile	
source ~/.bash_profile

# Install other dependencies
sudo apt-get install -y jq
sudo apt-get install -y python3-pip
sudo apt-get install -y python-pip
sudo apt-get install -y rename


# Install GoSpider
GO111MODULE=on go install github.com/jaeles-project/gospider@latest

# Install Hakrawler
GO111MODULE=on go install github.com/hakluke/hakrawler@latest

# Install SubDomainizer
TBC

# Install Subscraper
git clone https://github.com/m8sec/subscraper
cd subscraper
python3 setup.py install

# Install Amass
GO111MODULE=on go install -v github.com/owasp-amass/amass/v3/...@master


# Add nahamsec aliases to bash_profile
echo "installing bash_profile aliases from recon_profile"
git clone https://github.com/nahamsec/recon_profile.git
cd recon_profile
cat .bash_profile >> ~/.bash_profile
sleep 1
source ~/.bash_profile
cd ..
sudo rm -r recon_profile
echo "done"




