#!/bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get install -y python3-pip
sudo apt-get install -y python-pip
sudo apt-get install -y ruby-full
sudo apt-get install -y git
sudo apt-get install -y xargs
sudo apt-get install -y jq
sudo apt-get install -y nmap
sudo apt-get install -y golang

# Move Go to $PATH environment
sudo mv go /usr/local
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
echo 'export GOROOT=/usr/local/go' >> ~/.bash_profile
echo 'export GOPATH=$HOME/go'	>> ~/.bash_profile			
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH\n' >> ~/.bash_profile	
source ~/.bash_profile

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

# Create a tools folder in ~/
mkdir ~/tools
cd ~/tools/

# Install subfinder
echo "installing subfinder"
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
echo "done"

# Install WPScan
echo "installing wpscan"
sudo gem install wpscan
echo "done"

# Install dirsearch
echo "installing dirsearch"
git clone https://github.com/maurosoria/dirsearch.git
cd ~/tools/
echo "done"

# Install amass
echo "installing amass"
go install -v github.com/owasp-amass/amass/v3/...@master
echo "done"

# Install massdns
echo "installing massdns"
git clone https://github.com/blechschmidt/massdns.git
cd ~/tools/massdns
make
cd ~/tools/
echo "done"

# Install httprobe
echo "installing httprobe"
go get -u github.com/tomnomnom/httprobe 
echo "done"

# Clear up
cd ~/
sudo rm -r BBB-Script.git


